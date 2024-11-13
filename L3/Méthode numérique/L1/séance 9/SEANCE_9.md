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
  latex_envs:
    LaTeX_envs_menu_present: true
    autoclose: false
    autocomplete: true
    bibliofile: biblio.bib
    cite_by: apalike
    current_citInitial: 1
    eqLabelWithNumbers: true
    eqNumInitial: 1
    hotkeys:
      equation: Ctrl-E
      itemize: Ctrl-I
    labels_anchors: false
    latex_user_defs: false
    report_style_numbering: false
    user_envs_cfg: false
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


# Séance 9 : nombres aléatoires et Monte-Carlo

<!-- #region slideshow={"slide_type": "slide"} -->
## Processus aléatoires et nombres aléatoires

-   Certains processus en physique sont aléatoires, comme par exemple le
    phénomène de désintégration radioactive.

-   D'autres processus ne sont pas strictement aléatoires mais sont vus
    comme tels à l'échelle macroscopique. Un exemple est le mouvement
    Brownien.

-   L'utilisation de simulations par ordinateur permet d'étudier de tels
    phénomènes qui ne sont pas toujours accessibles par une approche
    analytique.

-   On trouve des exemples de ces méthodes déjà à l'époque des premiers
    ordinateurs: des expériences numériques ont été effectuées au cours
    du projet Manhattan pour calculer le libre parcours moyen d'un
    neutron dans un matériau.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
**Comment générer des nombres aléatoires avec un algorithme informatique
?**

-   Une suite aléatoire ne doit avoir aucune règle de prédiction
    identifiable.

-   Il n'est donc pas possible d'écrire un programme qui génère une
    suite strictement aléatoire!

-   Cependant il existe un grand nombre d'algorithmes déterministes qui
    permettent de générer des suites pseudo-aléatoires.

-   Dans des simulations numériques nous pouvons les traiter comme des
    vraies suites aléatoires.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
**Exemple :** Générateur congruentiel linéaire

$$x_{n+1}=(a x_n+c)\mod m$$

-   A chaque itération $n$ la valeur de $x_{n+1}$ dépend de la valeur de
    $x_n$ à l'itération précédente.

-   La qualité du générateur dépend des paramètres a, c et m.

-   La valeur initiale $x$ est la graine (seed) de la série et définit
    la suite qu'on va obtenir.


<img src="./plots/RNG.png" width="50%" />

*Résultat d'une génération aléatoire de points $(x_i,y_i)$.*
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## Nombres aléatoires en python

Le module `numpy.random` permet de générer des nombres pseudo-aléatoires
en utilisant des algorithmes déterministes.

La fonction `random()` génère des nombres pseudo-aléatoires uniformément
répartis dans l'intervalle \[0,1\[.
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
import numpy as np

np.random.random()
```

La fonction prend aussi comme argument le nombre de valeurs qu'on veut
générer.

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
np.random.random(3)
```

<!-- #region slideshow={"slide_type": "slide"} -->
La fonction `seed()` définit la graine du générateur et ainsi d'une
façon univoque la suite des nombres qui s'en suivent. L'utilisation
d'une graine peut être extrêmement pratique en phase de développement.
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
np.random.seed(10)
np.random.random()
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
np.random.random()
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
np.random.seed(10)
np.random.random()
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
np.random.random()
```

<!-- #region slideshow={"slide_type": "slide"} -->
**Autres fonctions:**

-   *np.random.uniform(low,high,size=None)*: renvoie des flottants
    (réels) aléatoires dans l'intervalle \[low, high\[

-   *np.random.randint(low,high,size=None)*: renvoie des entiers
    aléatoires dans l'intervalle `low` (inclus) à `high` (exclus).

-   *np.random.choice(s,size=None)*: génère un échantillonnage aléatoire
    à partir d'une séquence `s` donnée (`s` doit être 1D)

-   *np.random.permutation(s)* : permute aléatoirement un array ou
    renvoie une plage de nombres entiers permutés.

L'option `size` définit le nombre de valeurs qu'on veut générer. Le
résultat correspond à un objet de type array de taille `size`.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## Exemples d'utilisation des fonctions de np.random

Tirage de nombres entiers dans un intervalle :
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
np.random.randint(-5,10,size=4)
```

Tirage dans un ensemble prédéfini

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
np.random.choice([12.2,3.5,15,13],size=3)
```

<!-- #region slideshow={"slide_type": "slide"} -->
Permutations aléatoires dans un tableau :
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
np.random.permutation([12,23,45])
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
arr = np.arange(9).reshape((3, 3))
np.random.permutation(arr)
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
np.random.permutation(6)
```

<!-- #region slideshow={"slide_type": "slide"} -->
## Méthode Monte-Carlo

Les méthodes Monte-Carlo visent à calculer une valeur numérique
approchée en utilisant des procédés aléatoires.

Le nom fait allusion aux jeux de hasard pratiqués à Monte-Carlo.

Les méthodes suivent généralement les étapes suivantes:

-   on définit un domaine de possibles configurations d'entrée;

-   on génère les configurations d'entrée en suivant une loi
    probabiliste;

-   on calcule chacune des configurations suivant une loi déterministe;

-   on agrège les résultats.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
**Exemple:** quelle est la probabilité de toucher le bord d'un carreau
en lançant une pièce de monnaie sur un sol carrelé?

-   On définit la taille du sol ainsi que les dimensions des carreaux et
    de la pièce de monnaie.

-   On génère N configurations dans lesquelles la pièce de monnaie a été
    placée au hasard sur le sol.

-   On vérifie si la pièce de monnaie a touché le bord d'un carreau.

-   On dérive la fréquence des occurrences positives dans les N
    configurations. Pour N grand on peut estimer la probabilité
    souhaitée.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
**Exemples de domaines d'utilisation :**

-   Diffusion de particules dans un solide irradié.

-   Croissance cristalline.

-   Dynamique de populations.

-   Modélisation de trafic automobile.

-   Évolution de portfolio d'investissement.

-   Raytracing

-   \...

-   Calculs d'intégrales.


<img src="./plots/penetration-paths.png" width="100%" />


*Simulation Monte-Carlo de la scintillation d'un cristal YAG suite à
l'impact d'électrons de différentes énergies.*
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## Intégration par la méthode de Monte-Carlo

Il s'agit d'évaluer numériquement la valeur de l'intégrale d'une
fonction $f$ définie dans un espace $\mathbb{R}^d$

$$I=\int_\Omega f(\mathbf{x})d\mathbf{x}$$

La vitesse de convergence est un indicateur de l'efficacité de la
méthode utilisée pour évaluer l'intégrale.

-   Méthode des trapèzes: $n^{-2/d}$

-   Méthode de Simpson: $n^{-4/d}$

Pour ces méthodes la vitesse de convergence diminue quand $d$ augmente.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
Alors que d'autres algorithmes évaluent habituellement l'intégrande sur
une grille régulière, Monte Carlo choisit aléatoirement les points
auxquels l'intégrande est évaluée.

On choisi N points aléatoires dans le domaine d'intégration $\Omega$

$$\mathbf{x_1}\cdots\mathbf{x_N}\in \Omega$$

Le volume du domaine d'intégration est

$$V=\int_\Omega d\mathbf{x}$$

L'intégrale de la fonction f peut être approximée par:

$$I\approx Q_N\equiv \frac{V}{N} \sum_{i=1}^{N} f(\mathbf{x_i})$$
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
-   La vitesse de convergence est $n^{-1/2}$ indépendamment de la
    dimension du problème.

-   La méthode Monte Carlo est ainsi particulièrement utile pour les
    intégrales à plusieurs dimensions.

-   L'échantillonnage du domaine d'intégration est normalement homogène
    mais des lois de probabilité plus efficaces peuvent être choisies en
    fonction de la situation (cas par exemple de fonctions divergentes).
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
-   Il s'agit de trouver *manu militari* la valeur de la surface $S_L$
    d'un lac à l'intérieur d'un terrain de surface connue $S_T$.

-   On tire N boulets de canon sur le terrain d'une façon aléatoire et
    homogène et on compte le nombre de boulets M qui sont tombés dans le
    lac.

-   Pour un nombre N très grand on peut estimer la surface du lac comme:

    $$S_L=\frac{M}{N}S_T$$


<img src="./plots/lake1.png" width="25%" />


<img src="./plots/lake3.png" width="25%" />


Comment calculer $\pi$ par cette méthode?
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## DM2

Le DM2 est disponible aujourd'hui et à rendre avant le **mercredi 27 
avril, heure du cours**

1.  Ouvrir un terminal:

    -   soit sur https://jupyterhub.ijclab.in2p3.fr

    -   soit sur un ordinateur du 336

2.  Télécharger le DM2

        methnum fetch L1/DM2 TONGROUPE

    en remplaçant TONGROUPE par ton numéro de groupe.

3.  Pour soumettre le DM2, dans le terminal taper:

        methnum submit L1/DM2 TONGROUPE
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## À vos TPs !

1.  Ouvrir un terminal:

    -   soit sur https://jupyterhub.ijclab.in2p3.fr

    -   soit sur un ordinateur du 336

2.  Télécharger la séance d'aujourd'hui:

        methnum fetch L1/Seance9 TONGROUPE

    en remplaçant TONGROUPE par ton numéro de groupe.

3.  Sur un ordinateur du bâtiment 336 uniquement, lancer le jupyter:

        methnum jupyter notebook

4.  Pour soumettre la séance, dans le terminal taper:

        methnum submit L1/Seance9 TONGROUPE
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
Rappel: votre gitlab personnel sert de sauvegarde pour passer vos
documents d'une plateforme à l'autre via les commandes fetch/submit.


<img src="../scripts/figures/methnum_structure.png" width="100%" />
<!-- #endregion -->
