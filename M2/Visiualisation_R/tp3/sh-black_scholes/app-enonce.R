# =============================================================================
# Black-Scholes-Merton (1973) : exercice
# Source d'origine : https://srdas.github.io/MLBook/Shiny.html
# =============================================================================

##### CONSIGNES #####
# L'objectif est de construire progressivement une application de pricing
# d'options européennes comportant 4 onglets. Les "???" indiquent le code à
# compléter. Attention : l'application ne peut pas être lancée tant qu'il
# reste des "???" dans le fichier.
#
# Q1. Onglet "Prix vs sous-jacent"
#   a. UI : compléter les deux numericInput() (identifiants "S" et "K", valeur
#      par défaut 100). Puis, sur le modèle du slider de maturité, ajouter :
#      - un slider "sigma" pour la volatilité : de 0.05 à 0.9, valeur 0.2,
#        pas de 0.01 ;
#      - un slider "r" pour le taux sans risque : de 0 à 0.2, valeur 0.02,
#        pas de 0.005.
#   b. Server : compléter les sorties prix_put et parite_cp (valeur C - P)
#      sur le modèle de prix_call.
#   c. Server : compléter plot_prix pour représenter, en fonction de S, la
#      valeur du call et du put (traits pleins) et leur payoff à maturité
#      (tirets). Une ligne verticale indique la valeur courante de S.
#   d. Server : compléter params_prix pour afficher sous la figure les
#      paramètres fixes K, T, sigma et r.
#   e. Lancer l'application.
#
# Q2. Onglet "Sensibilités"
#   Ajouter un onglet représentant le prix du call et du put en fonction d'une
#   variable choisie par l'utilisateur (S, K, T, sigma ou r), les autres
#   paramètres étant fixés à leur valeur courante.
#   Indications : selectInput() avec le vecteur choix_sensi.
#
# Q3. Onglet "Grecs"
#   Ajouter un onglet représentant les 5 grecs (delta, gamma, vega, theta,
#   rho) en fonction de S, avec un panneau par grec.
#   Indications : ajouter le calcul des grecs à la fonction bs() en vous appuyant
#   sur la référence wikipedia. 
#
# Q4. Onglet "Carte de chaleur"
#   Ajouter un onglet représentant une grandeur au choix (prix du call, prix
#   du put, gamma ou vega) en fonction de S et de sigma. Un point blanc indique la
#   situation courante.
#   Indications : selectInput() avec le vecteur choix_heat ; expand.grid()
#   pour la grille (S, sigma) ; geom_raster(), geom_contour() et
#   scale_fill_viridis_c().

library(shiny)
library(plotly)
library(ggplot2)
library(dplyr)
library(tidyr)
library(scales)

##### FONCTIONS #####

# Prix et grecs d'options européennes sans dividende
bs <- function(S, K, T, sigma, r) {
  d1  <- (log(S / K) + (r + 0.5 * sigma^2) * T) / (sigma * sqrt(T))
  d2  <- d1 - sigma * sqrt(T)
  dfr <- exp(-r * T)
  data.frame(
    S, K, T, sigma, r,
    valeur_call = S * pnorm(d1) - K * dfr * pnorm(d2),
    valeur_put  = K * dfr * pnorm(-d2) - S * pnorm(-d1)
    # Commentaires à retirer à partir de la question Q3
    # ,
    # delta_call  = ??? ,
    # delta_put   = ??? ,
    # gamma       = ???,
    # vega        = ??? / 100,              # pour 1 pt de vol
    # theta_call  = ??? / 365,          # par jour
    # theta_put   = ??? / 365,
    # rho_call    = ??? / 100,              # pour 1 pt de taux
    # rho_put     = ???/ 100
  )
}

# Grille de prix du sous-jacent couvrant à la fois S et K
grille_S <- function(S, K, n = 200) {
  seq(0.5 * min(S, K), 1.5 * max(S, K), length.out = n)
}

# Couleurs fixes pour toute l'application (palette Okabe-Ito)
couleurs <- c(call = "#0072B2", put = "#D55E00")

# Libellés des listes déroulantes (utilisés en Q2 et Q4)
choix_sensi <- c("Sous-jacent S" = "S", "Strike K" = "K", "Maturité T" = "T",
                 "Volatilité σ" = "sigma", "Taux sans risque r" = "r")
choix_heat  <- c("Prix du call" = "valeur_call", "Prix du put" = "valeur_put",
                 "Gamma" = "gamma", "Vega" = "vega")

##### UI #####

# On recrée des encadrés pour les valeurs call, put et parité
css_kpi <- "
  .kpi { padding: 12px 15px; border-radius: 6px; color: white; margin-bottom: 15px; }
  .kpi h4 { margin-top: 0; font-size: 14px; opacity: 0.9; }
  .kpi .valeur { font-size: 28px; font-weight: bold; }
  .kpi .detail { font-size: 13px; }
  .kpi-call   { background-color: #0072B2; }
  .kpi-put    { background-color: #D55E00; }
  .kpi-parite { background-color: #6c757d; }
  .param-box  { margin-top: 10px; padding: 8px 12px; font-size: 13px;
                background-color: #f5f5f5; border-left: 4px solid #6c757d; }
"

ui <- fluidPage(
  tags$head(tags$style(HTML(css_kpi))),
  
  titlePanel("Black-Scholes-Merton (1973)"),
  
  sidebarLayout(
    sidebarPanel(
      width = 3,
      numericInput(???, "Prix du sous-jacent (S)", value = ???, min = 0.01),
      numericInput(???, "Strike (K)", value = ???, min = 0.01),
      sliderInput("T", "Maturité (années)", min = 0.05, max = 5, value = 1, step = 0.05),
      sliderInput(???),
      sliderInput(???),
      hr(),
      p("Pour en savoir plus :",
        a("modèle de Black-Scholes",
          href = "https://en.wikipedia.org/wiki/Black%E2%80%93Scholes_model",
          target = "_blank"))
    ),
    
    mainPanel(
      width = 9,
      
      fluidRow(
        column(4, div(class = "kpi kpi-call",
                      h4(icon("arrow-trend-up"), " Call européen"),
                      div(class = "valeur", textOutput("prix_call")))),
        column(4, div(class = "kpi kpi-put",
                      h4(icon("arrow-trend-down"), " Put européen"),
                      div(class = "valeur", textOutput("prix_put")))),
        column(4, div(class = "kpi kpi-parite",
                      h4(icon("right-left"), " Parité call-put : C − P"),
                      div(class = "valeur", textOutput("parite_cp"))))
      ),
      
      tabsetPanel(
        tabPanel(
          "Prix vs sous-jacent",
          br(),
          plotlyOutput("plot_prix"),
          div(class = "param-box", textOutput("params_prix"))
        )
        # Q2 : ajouter ici l'onglet "Sensibilités"
        # Q3 : ajouter ici l'onglet "Grecs"
        # Q4 : ajouter ici l'onglet "Carte de chaleur"
        # Attention : séparer les tabPanel() par des virgules
      )
    )
  )
)

##### SERVER #####

server <- function(input, output) {
  
  # --- Paramètres centralisés et validés ---------------------------------
  params <- reactive({
    validate(
      need(input$S > 0, "Le prix du sous-jacent doit être strictement positif"),
      need(input$K > 0, "Le strike doit être strictement positif")
    )
    list(S = input$S, K = input$K, T = input$T,
         sigma = input$sigma, r = input$r)
  })
  
  # --- Prix au point courant ---------------------------------------------
  prix <- reactive({
    p <- params()
    bs(S = p$S, K = p$K, T = p$T, sigma = p$sigma, r = p$r)
  })
  
  output$prix_call <- renderText(sprintf("%.4f", prix()$valeur_call))
  output$prix_put  <- ???
    output$parite_cp <- ???
    
    # --- Onglet 1 : prix vs sous-jacent avec payoff ------------------------
  output$plot_prix <- renderPlotly({
    p <- params()
    
    # valeurs et payoffs sur une grille de S, puis passage au format long :
    # les colonnes valeur_call, payoff_put, ... sont découpées en deux
    # variables "type" (valeur / payoff) et "option" (call / put)
    df <- bs(S = grille_S(p$S, p$K), K = p$K, T = p$T, sigma = p$sigma, r = p$r) %>%
      mutate(payoff_call = ???,
             payoff_put  = ???) %>%
      select(S, valeur_call, valeur_put, payoff_call, payoff_put) %>%
      pivot_longer(-S, names_to = c("type", "option"), names_sep = ???)
    
    g <- ggplot(df, aes(S, value, colour = ???, linetype = ???,
                        group = interaction(option, type),
                        text = sprintf("%s %s : %.4f", type, option, value))) +
      geom_line(linewidth = 0.5) +
      geom_vline(xintercept = ???, linetype = "dotted", colour = "grey40") +
      scale_colour_manual(values = couleurs) +
      scale_linetype_manual(values = c(valeur = "solid", payoff = "dashed")) +
      labs(x = "Prix du sous-jacent S", y = "Prix de l'option",
           colour = NULL, linetype = NULL,
           title = "Valeur de l'option vs payoff à maturité") +
      theme_minimal(base_size = 13)
    
    ggplotly(g, tooltip = "text") %>% layout(hovermode = "x unified")
  })
  
  # Texte de la boîte sous la figure
  output$params_prix <- renderText({
    p <- params()
    sprintf("Paramètres fixes : K = %g · T = %g an(s) · σ = %.0f %% · r = %.1f %%",
            ???)
  })
  
  # --- Q2 : onglet Sensibilités ------------------------------------------
  
  # --- Q3 : onglet Grecs -------------------------------------------------
  
  # --- Q4 : onglet Carte de chaleur --------------------------------------
  
}

##### LANCEMENT #####

???