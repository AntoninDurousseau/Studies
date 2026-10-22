---
jupyter:
  jupytext:
    notebook_metadata_filter: all
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.14.5
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
  language_info:
    codemirror_mode:
      name: ipython
      version: 3
    file_extension: .py
    mimetype: text/x-python
    name: python
    nbconvert_exporter: python
    pygments_lexer: ipython3
    version: 3.10.8
  metadata:
    execution:
      allow_errors: true
  rise:
    enable_chalkboard: true
    height: 90%
    scroll: true
    width: 90%
  toc:
    base_numbering: 1
    nav_menu: {}
    number_sections: true
    sideBar: true
    skip_h1_title: false
    title_cell: Table of Contents
    title_sidebar: Contents
    toc_cell: false
    toc_position: {}
    toc_section_display: true
    toc_window_display: false
  varInspector:
    cols:
      lenName: 16
      lenType: 16
      lenVar: 40
    kernels_config:
      python:
        delete_cmd_postfix: ''
        delete_cmd_prefix: 'del '
        library: var_list.py
        varRefreshCmd: print(var_dic_list())
      r:
        delete_cmd_postfix: ') '
        delete_cmd_prefix: rm(
        library: var_list.r
        varRefreshCmd: 'cat(var_dic_list()) '
    types_to_exclude:
    - module
    - function
    - builtin_function_or_method
    - instance
    - _Feature
    window_display: false
---

Merci de **ne pas modifier** le nom de ce notebook (même pour y inclure son nom).

Quelques conseils:
- pour exécutez une cellule, cliquez sur le bouton *Exécuter* ci-dessus ou tapez **Shift+Enter**
- si l'exécution d'une cellule prend trop de temps, sélectionner dans le menu ci-dessus *Noyau/Interrompre*
- en cas de très gros plantage *Noyau/Redémarrer*
- **sauvegardez régulièrement vos réponses** en cliquant sur l'icone disquette ci-dessus à gauche, ou *Fichier/Créer une nouvelle sauvegarde*

----------------------------------------------------------------------------


# Séance 8 : intégrales

<!-- #region slideshow={"slide_type": "slide"} -->
## Calculs d'intégrales

On souhaite calculer la valeur de l'intégrale d'une fonction $f$ entre
deux points connus, $a$ et $b$ : $\displaystyle{\int_a^b f(x){\rm d}x}$

-   Si la primitive $F$ de $f$ est connue analytiquement, l'intégrale
    est simplement : $\displaystyle{\int_a^b f(x){\rm d}x = F(b) - F(a)}$

-   Si la fonction $f$ est échantillonnée en un nombre fini de points,
    $f(a)$,...,$f(x_i)$,..., $f(b)$, il est également possible
    **d'évaluer numériquement l'intégrale en évaluant l'aire sous la
    courbe $f(x)$ comprise entre les abscisses $x_i=a$ et $x_f=b$.**

Cette seconde approche numérique est très utile (en particulier lorsque
la primitive de la fonction f n'est pas connue analytiquement).

Enfin, la comparaison entre le calcul analytique et numérique est
essentielle car elle permet de vérifier la validité des algorithmes et
d'évaluer la précision des calculs numériques.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## Calculs d'intégrales

Losque, la fonction $f$ est échantillonnée en un nombre fini de points,
différentes méthodes d'intégration numérique peuvent être utilisées :

-   intégration à partir d'une interpolation polynomiale de $f$ entre
    points régulièrement espacés $\rightarrow$**formules de Newton -
    Cotes** (*simple et robuste - standard pour une fonction facile à
    évaluer*)

-   "optimisation" des points où sont évalués la fonction $\rightarrow$
    **quadrature Gaussienne** (*plus de liberté - plus difficile
    d'estimer l'erreur commise*)

-   échantillonage aléatoire de la fonction $\rightarrow$ **calcul
    "Monte-Carlo"** (*particulièrement utile à N-dimensions*)

**Cette séance : formules de Newton - Cotes + estimation de la
précision.**
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## Formules de Newton - Cotes

$f(x)$ est échantillonnée entre $a$ et $b$. On souhaite estimer
$I=\displaystyle{\int_a^b f(x){\rm d}x}$.

-   ordre 0 : on approxime $f$ par une fonction en escalier évaluée en
    un point par sous intervalle $\rightarrow$ **somme de Riemann**

-   ordre 1 : on approxime $f$ par une fonction affine évaluée en deux
    points par sous intervalle $\rightarrow$ **méthode des trapèzes**

-   ordre 2 : on approxime $f$ par une parabole évaluée en trois points
    par sous intervalle $\rightarrow$ **méthode de Simpson**


<img src="plots/methodes_integration.png" width="80%" />


Ces méthodes ne sont rigoureusement exactes que pour les polynômes
d'ordre associé $\rightarrow$ **erreur commise ?**
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
### Newton - Cotes - Ordre 0 : somme de Riemann

On considère d'abord **deux points $[a,b]$** espacés par un pas $h=b-a$.

Pour deux points seulement, la formule de Riemann donne :

$$\int_a^b f(x){\rm d}x \simeq h \times f(\xi) = I_f$$

$\xi$ est un point d'abscisse quelconque entre les deux bornes $a$ et
$b$ qui définit la hauteur $f(\xi)$ du rectangle de largeur $h$.

**Quelle est l'erreur commise sur $I$ par la méthodes des rectangles ?**


<img src="plots/681px-Integration_num_rectangles_erreur.png" width="35%" />
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
**La position de $\xi$ est cruciale !** Il suffit d'un D.L. pour le
voir:

$$f(x) = f(\xi) + f'(\xi)\times(x-\xi) + f''(\xi)\times\frac{(x-\xi)^2}{2!} + \ldots$$

Si on intègre ce DL sur la variable $x$ dans l'intervalle $[a,b]$,
l'erreur est

$$\int_a^b f(x){\rm d}x - I_f = \frac{f'(\xi)}{2} \left[ (x-\xi)^{2} \right]_{a}^{b} + \frac{f''(\xi)}{3 \times 2!} \left[ (x-\xi)^{3} \right]_{a}^{b} + \ldots$$

-   soit pour $\xi = a$ ou $\xi =b$ une erreur
    $\displaystyle{\int_a^b f(x){\rm d}x - I_f = \frac{h^2}{2}f'(\xi)  + \ldots}$

-   soit pour $\xi = \displaystyle{\frac{a+b}{2}}$ une erreur
    $\displaystyle{\int_a^b f(x){\rm d}x - I_f = \frac{h^3}{24}f''(\xi)  + \ldots}$

en n'oubliant pas que $h$ est censé être petit.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
Généralisons à $n$ points $x_{i}$ séparés d'un pas $h=\displaystyle{\frac{b-a}{n}}$, et
calculons l'erreur commise sur $I$.

-   Si on fait la **somme à gauche** $\xi_i=x_i = a + i\times h$ :

    $$I = \int_a^b f(x){\rm d}x = \sum_{i=0}^{n-1}h f(x_i) + n\times O(h^2f') = \sum_{i=0}^{n-1} hf(x_i)  + O\left(\frac{(b-a)^2f'}{n}\right)$$

    l'erreur est en $O(1/n)$.

-   Si on fait la **somme à droite**
    $\xi_i = x_{i+1} = a + (i+1)\times h$ :

    $$I = \int_a^b f(x){\rm d}x = \sum_{i=1}^{n}h f(x_i) + n\times O(h^2f') = \sum_{i=1}^{n} hf(x_i)  + O\left(\frac{(b-a)^2f'}{n}\right)$$

    l'erreur est en $O(1/n)$.

-   Si on fait la **somme au milieu**
    $\xi_i = (x_i+x_{i+1})/2 = a + (i+\frac{1}{2})\times h$ :

    $$I = \int_a^b f(x){\rm d}x = \sum_{i=0}^{n-1} h f(\xi_i) + n\times O(h^3f'') = \sum_{i=0}^{n-1}h f(\xi_i) + O\left(\frac{(b-a)^3f''}{n^2}\right)$$

    l'erreur est en $O(1/n^2)$.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
<table> <tr><td><img
src="https://upload.wikimedia.org/wikipedia/commons/1/19/Riemann_sum\_(leftbox).gif"
alt="Riemann sum (leftbox).gif" width="100%"\> Somme à
gauche</td><td> <img
src="https://upload.wikimedia.org/wikipedia/commons/6/61/Riemann_sum\_(rightbox).gif"
alt="Riemann sum (rightbox).gif" width="100%"\> Somme à
droite</td><td><img
src="https://upload.wikimedia.org/wikipedia/commons/c/c3/Riemann_sum\_(middlebox).gif"
alt="Riemann sum (middlebox).gif" width="100%"\> Somme au
milieu</tr> </table>

Source : <https://fr.wikipedia.org/wiki/Somme_de_Riemann>.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
### Newton - Cotes - Ordre 1 : méthode des trapèzes

La **méthode des trapèzes** consiste à approximer la fonction par des
**segments de droite sur des sous-intervalles.**


<img src="plots/681px-Integration_num_trapezes.png" width="30%" />

**deux points**, à l'aide de la formule de l'aire du trapèze,
l'intégrale s'écrit :

$$I = \int_a^b f(x){\rm d}x = h\times\frac{f(a)+f(b)}{2} + O(h^3f'')$$

*Notez que l'erreur est du même ordre que celle obtenue pour la somme de
Riemann au milieu.*
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
En généralisant à $n$ points, pour $x_i = a + i\times h$, on obtient :

$$I = \int_a^b f(x){\rm d}x = h\times\left(\frac{f_0}{2} + f_1 + f_2 + \ldots + f_{n-1} + \frac{f_{n}}{2}\right) + O\left(\frac{(b-a)^3f''}{n^2}\right)$$

en notant $f_i=f(x_i)$.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
### Newton - Cotes - Ordre 2 : méthode de Simpson

La **méthode de Simpson** consiste à approximer la fonction $f$ par des
**morceaux de paraboles** (avec un nombre impair de points !)

<img src="plots/681px-Integration_num_Simpson.png" width="30%" />


Pour trois points d'abscisse $a$, $m=(a+b)/2$ et $b$, le polynôme
approximant est :

$$P(x) = f(a)\frac{(x-m)(x-b)}{(a-m)(a-b)} + f(m)\frac{(x-a)(x-b)}{(m-a)(m-b)} + f(b)\frac{(x-a)(x-m)}{(b-a)(b-m)}$$
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
Pour trois points seulement, l'intégrale s'écrit :

$$\begin{aligned}
I = \int_a^b f(x){\rm d}x & = \frac{b-a}{2}\times\left(\frac{1}{3}f(a) + \frac{4}{3}f\left(\frac{a+b}{2}\right) +\frac{1}{3}f(b)\right) + O(h^5f^{(4)}) \\ & \simeq \int_{a}^{b} P(x) {\rm d}x
\end{aligned}$$

En généralisant à $n+1$ points, pour $x_i = a + i\times h$, on obtient :

$$\begin{aligned}
I = \int_a^b f(x){\rm d}x & = h\times\left(\frac{1}{3}f_0 + \frac{4}{3}f_1 + \frac{2}{3}f_2 + \frac{4}{3}f_3 + \ldots + \frac{2}{3}f_{n-3} + \frac{4}{3}f_{n-2} + \frac{1}{3}f_{n-1}\right)\\ & \qquad + O\left(\frac{(b-a)^5f^{(4)}}{n^4}\right)
\end{aligned}$$
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## Dans la pratique
### Module ```integrate```

Dans python, on peut utiliser le module `integrate` de `scipy` pour
calculer une intégrale à partir d'un numpy array.
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
from scipy import integrate
help(integrate)
```

<!-- #region slideshow={"slide_type": "slide"} -->
Par exemple, la fonction `cumtrapz` de `integrate` renvoie l'ensemble
des intégrales obtenues par la méthode des trapèzes de $x_0$ à $x_i$,
soit une approximation numérique de la primitive :
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
from scipy import integrate
import numpy as np
import matplotlib . pyplot as plt
x = np.linspace(-2 , 2, 20)
y = x
y_int = integrate.cumtrapz(y , x, initial=0)
z = x*x/2 - 2
plt.plot(x, y_int,'ro', label=' cumtrapz')
plt.plot(x, z, label='analytic')
plt.show()
```

<!-- #region slideshow={"slide_type": "slide"} -->
### Fonction `quad`

Un outil général d'intégration des fonctions 1D existe dans le module
`scipy.integrate` : `quad` (pour quadrature). Il prend comme argument :
une fonction et ses bornes puis renvoie l'intégrale et la précision
absolue sur cette intégrale.
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
from scipy.integrate import quad

#fonction x^2
def f(x):
    return x*x

# Corps du programme
a = 0 # borne inf de l'integration
b = 1 # borne sup de l'integration
print(quad(f,a,b))
```

<!-- #region slideshow={"slide_type": "slide"} -->
La fonction `quad` fait appel sans le dire à des méthodes identiques ou
similaires à celles développées dans le cours.

Astuce : pour les fonctions python extrêmement simples (ou à plusieurs
paramètres), on peut utiliser la syntaxe `lambda` de python. Le code
suivant est parfaitement équivalent au précédent :
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
from scipy.integrate import quad

#Corps du programme
a = 0 #borne inf de l'integration
b = 1 #borne sup de l'integration
f = lambda x: x*x #fonction x^2
print(quad(f,a,b))
```

<!-- #region slideshow={"slide_type": "slide"} -->
### Intégrales "impropres" convergentes

Que faire quand, bien que l'intégrale converge :

-   la fonction ne peut pas être évaluée en un de ces points
    ($\sin(x)/x$ en $x=0$)

-   la fonction diverge en une de ces bornes ($1/\sqrt{x}$ en $x=0$)

-   l'intégrale court jusqu'à une borne infinie
    ($\int_0^\infty {\rm e}^{-x}{\rm d}x$)

Pour les deux premiers points, en particulier le premier, un moyen de
s'en sortir consiste à utiliser une **intégration dite ouverte** (par
opposition à fermée\...), i.e. plutôt que d'effectuer l'intégrale entre
$a$ et $b$ inclus, on l'effectue **entre $a+h$ et $b-h$ inclus.**
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
Lorsqu'une borne est infinie, si la fonction chute suffisamment
rapidement, on peut se contenter d'imposer une **borne supérieure
"grande"** (à déterminer au cas par cas avec une étude de convergence).

On peut aussi recourir à un **changement de variable**, par exemple si
$b\rightarrow\infty$ et $a>0$ :

$$\int_a^b f(x) dx = \int_{1/b}^{1/a}f\left(\frac{1}{t}\right) \frac{{\rm d}t}{t^2}$$

ou encore :

$$\int_a^b f(x) dx = \int_{\exp(-b)}^{\exp(-a)}f(-\ln t) \frac{{\rm d}t}{t}$$

qui sont très aisés à mettre en place par le développeur.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## A retenir

La précision d'une intégrale dépend de la **méthode utilisée** :

-   Riemann (milieu) : $O\left(\frac{(b-a)^3f''}{n^2}\right)$

-   trapèzes : $O\left(\frac{(b-a)^3f''}{n^2}\right)$

-   Simpson : $O\left(\frac{(b-a)^5f^{(4)}}{n^4}\right)$

et du **pas d'intégration $h$**.

Les fonctions de la librairie `scipy` sont confortables pour les
développeurs mais il ne faut jamais oublier qu'elles fournissent un
résultat avec une certaine **précision** qui dépend entre autre de
**l'échantillonnage** de la fonction.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## À vos TPs !

1.  Ouvrir un terminal:

    -   soit sur https://jupyterhub.ijclab.in2p3.fr

    -   soit sur un ordinateur du 336

2.  Télécharger la séance d'aujourd'hui:

        methnum fetch L1/Seance8 TONGROUPE

    en remplaçant TONGROUPE par ton numéro de groupe.

3.  Sur un ordinateur du bâtiment 336 uniquement, lancer le jupyter:

        methnum jupyter notebook

4.  Pour soumettre la séance, dans le terminal taper:

        methnum submit L1/Seance8 TONGROUPE
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
Rappel: votre gitlab personnel sert de sauvegarde pour passer vos
documents d'une plateforme à l'autre via les commandes methnum/fetch.


<img src="../scripts/figures/methnum_structure.png" width="100%" />
<!-- #endregion -->
