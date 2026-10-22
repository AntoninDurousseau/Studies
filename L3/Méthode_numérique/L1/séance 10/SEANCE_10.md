---
jupyter:
  jupytext:
    notebook_metadata_filter: all
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.13.6
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
    version: 3.9.7
  metadata:
    execution:
      allow_errors: true
  rise:
    enable_chalkboard: true
    height: 90%
    scroll: true
    width: 90%
---

Merci de **ne pas modifier** le nom de ce notebook (même pour y inclure son nom).

Quelques conseils:
- pour exécutez une cellule, cliquez sur le bouton *Exécuter* ci-dessus ou tapez **Shift+Enter**
- si l'exécution d'une cellule prend trop de temps, sélectionner dans le menu ci-dessus *Noyau/Interrompre*
- en cas de très gros plantage *Noyau/Redémarrer*
- **sauvegardez régulièrement vos réponses** en cliquant sur l'icone disquette ci-dessus à gauche, ou *Fichier/Créer une nouvelle sauvegarde*

----------------------------------------------------------------------------


# Séance 10 : librairie Pandas

<!-- #region slideshow={"slide_type": "slide"} -->
## Fonctions statistiques de numpy

Numpy intègre un ensemble de fonctions statistiques pouvant être
appliquées à un tableau (array) :

-   `np.amin(a)`: renvoie la valeur minimale du tableau `a`.

-   `np.amax(a)`: renvoie la valeur maximale du tableau `a`.

-   `np.percentile(a,q,axis=None)` : renvoie le q-ième percentile du
    tableau `a`.

Exemple: `np.percentile(a,30)` renvoie la valeur $x$ pour laquelle 30%
des valeurs de a sont inférieures à $x$.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
-   `np.mean(a)` : renvoie la moyenne des valeurs de `a`:

    $$\bar{x}=\frac{1}{N}\sum_{i=1}^{N}x_i$$

-   `np.median(a)` : renvoie la médiane des valeurs de `a`, i.e. la
    valeur $x$ pour laquelle la moitié des valeurs de `a` est inférieure
    à $x$ et l'autre moitié supérieure à $x$. Cette fonction est donc
    équivalente à `np.percentile(a,50,axis=None)`

-   `np.std(a)` : renvoie l'écart type des valeurs de `a`:

    $$\sigma_X = \sqrt{\frac{\sum_{i=1}^{N} (x_i-\bar{x})^2}{N}}$$
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
import numpy as np

notes = np.array([19, 10, 14, 15, 8, 18])
print(np.mean(notes))
print(np.median(notes))
print(np.std(notes))
```

<!-- #region slideshow={"slide_type": "slide"} -->
Numpy permet des analyses statistiques raffinées sur des tableaux de
données numériques du même type. Cependant, il est courant de travailler
avec des tableaux qui contiennent des données de types différents et
dans lesquels des cases peuvent être vides:

  Animal |      Description |     Price (\$)
  --------------|----------------|------------
  Gnat |        per gram |             13.65
   |            each |                  0.01
  Gnu |         stuffed |              92.50
  Emu |         stuffed |              33.33
  Armadillo |   frozen |                8.99

Ces structures ne peuvent pas être analysées simplement en utilisant le
module numpy.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## Dictionnaires

Les dictionnaires sont un type de base de Python, ils permettent
d'associer un élément à une clef.

On appelle les éléments par leur clef et non pas par leur indice.

-   Les dictionnaires sont délimités par des accolades.

-   Clef et élément sont reliés par le symbole deux points (:).

-   Un dictionnaire admet différents types pour les clefs et les
    éléments.

```{=html}
<!-- -->
```
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
s = {"a": 3, 0:43, "c":[3,4,23], "d":"bla"}
print(s)
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(type(s))
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(len(s))
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(s["c"])
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(s["a"])
```

Remarque: une clef numérique n'indique pas une position!

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(s[0])
```

<!-- #region slideshow={"slide_type": "slide"} -->
On peut modifier, ajouter ou retirer des termes d'un dictionnaire:
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
d={"a":1,"b":2}
d["b"]=3
print(d)
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
d["c"]=10
print(d)
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
del d["a"]
print(d)
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
d.pop('c')
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(d)
```

<!-- #region slideshow={"slide_type": "slide"} -->
On accède aux clefs et aux termes avec les méthodes `.keys()` et
`.items()`:
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
s={"a":3, 0:43, "c":[3,4,23], "d":"bla"}
print(s.keys())
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(s.items())
```

<!-- #region slideshow={"slide_type": "slide"} -->
On peut parcourir un dictionnaire :
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
for c in s :
    print("clef",c,"terme",s[c])
```

<!-- #region slideshow={"slide_type": "slide"} -->
## La librairie Pandas

La librairie Pandas, basée sur Numpy, est un outil très performant pour
manipuler et analyser des données. Elle permet de traiter des tableaux
non homogènes avec éventuellement des cases vides. Elle intègre des
outils de manipulation de données, d'analyse statistique et de
visualisation.
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
import pandas as pd
```

<!-- #region slideshow={"slide_type": "slide"} -->
## Series

Une série est un tableau unidimensionnel pouvant contenir n'importe quel
type de donnée. Chaque élément est repéré par un indice associé à sa
position dans le tableau:
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
s = pd.Series([3,-5,7,4])
print(s[0])
```

On peut aussi attribuer des indices de type string:

   a |   3
  ------|----
   b |   -5
   c |   7
   d |   4

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
s=pd.Series([3,-5,7,4], index=['a','b','c','d'])
```

<!-- #region slideshow={"slide_type": "slide"} -->
Contrairement aux dictionnaires, on appelle les éléments d'une série par
leur position ou par leur indice :
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print("s[0] =", s[0], ", s['c'] =", s['c'], ", s[2] =", s[2])
```

On peut utiliser les techniques de slicing en utilisant les positions:

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(s[0::2])
```

<!-- #region slideshow={"slide_type": "slide"} -->
Mais il est également possible de faire du slicing en utilisant les
indices contenus dans l'index :
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(s['a':'c'])
```

ainsi que faire des opérations sur les données de la série:

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
(s['a':'c']+1)**2
```

<!-- #region slideshow={"slide_type": "slide"} -->
## DataFrame

Un DataFrame correspond à un tableau 2D avec des étiquettes attribuées à
chaque colonne

  **Country** |   **Capital** |     **Population**
  ----------------|----------------|----------------
  Belgium |       Brussels |              11190846
  India |         New Delhi |           1303171035
  Brazil |        Brasilia |             207847528
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
On peut facilement construire un dataframe à partir d'un dictionnaire:
<!-- #endregion -->

```python

```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
data = {'Country': ['Belgium',  'India',  'Brazil'],
        'Capital': ['Brussels',  'New Delhi',  'Brasilia'],
        'Population': [11190846, 1303171035, 207847528]}

df = pd.DataFrame(data)
```

à partir de séries:

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
country = pd.Series(["Belgium","India","Brazil"])
capital = pd.Series(["Brussels","New Delhi","Brasilia"])
population = pd.Series([11190846, 1303171035, 207847528])
df=pd.DataFrame({"Country":country, "Capital":capital,
                 "Population":population })
```

ou à partir d'un tableau `numpy` en donnant des noms aux lignes et aux
colonnes:

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df_numpy = pd.DataFrame(np.random.rand(3, 2),
                        columns=['foo', 'bar'],
                        index=['a', 'b', 'c'])
```

<!-- #region slideshow={"slide_type": "slide"} -->
Sans spécification, un indice numérique est attribué à chaque ligne:
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(df)
```

On peut appeler les colonnes d'un dataframe par leur nom, on obtient
ainsi une série:

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(df['Country'])
```

ou simplement :

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(df.Country)
```

<!-- #region slideshow={"slide_type": "slide"} -->
On peut extraire une série en appelant son indice dans le dataframe avec
la méthode `.iloc[indice]`:
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(df.iloc[0])
```

Cependant la méthode `.iloc` n'est valable que si l'index est constitué
d'entiers. Si ce n'est pas le cas, il faut utiliser la méthode `.loc[]`
par exemple si on a utilisé le nom des pays en index :

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df_new = df.set_index("Country")
print(df_new.loc["Belgium"])
```

<!-- #region slideshow={"slide_type": "slide"} -->
Comme pour les Series on peut utiliser les techniques de slicing sur un
DataFrame :
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(df[0:2])
```

Il est possible de coupler le slicing avec la méthode de clef-indice :

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(df[0:2]["Country"])
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(df["Country"][2])
```

<!-- #region slideshow={"slide_type": "slide"} -->
## Importer des données

Pandas permet d'importer/exporter directement des bases de données dans
différents formats de fichiers: csv, xls, json, sql\...

-   pd.read_excel()

-   pd.read_csv()

Par défaut, la première ligne du fichier donne les noms des colonnes.

Exemple pour un fichier csv:
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
!cat data/countries.csv
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df=pd.read_csv("data/countries.csv")
print(df)
```

On peut connaître le nom des colonnes par l'attribut `.columns`:

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df=pd.read_csv("data/countries.csv")
print(df.columns)
```

<!-- #region slideshow={"slide_type": "slide"} -->
Pandas gère aussi automatiquement les données manquantes:
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
!cat data/countries_missing.csv
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df=pd.read_csv("data/countries_missing.csv")
print(df)
```

<!-- #region slideshow={"slide_type": "slide"} -->
On peut utiliser une colonne spécifique dans le fichier pour donner des
noms aux lignes:
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df=pd.read_csv("data/countries.csv", index_col='Country')
print(df.columns)
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(df.index)
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
print(df.loc['Belgium'])
```

<!-- #region slideshow={"slide_type": "slide"} -->
Pandas permet de fusionner différents dataframes en utilisant les noms
des colonnes. Le paramètre axis=1 permet d'ajouter des colonnes :
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
!cat data/countries.csv
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
!cat data/countries2.csv
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
c1=pd.read_csv("data/countries.csv",index_col="Country")
c2=pd.read_csv("data/countries2.csv",index_col="Country")
d=pd.concat([c1,c2],axis = 1)
print(d)
```

<!-- #region slideshow={"slide_type": "slide"} -->
Le paramètre `axis=0` permet d'ajouter des lignes :
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
!cat data/countries3.csv
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
c1=pd.read_csv("data/countries.csv",index_col="Country")
c2=pd.read_csv("data/countries2.csv",index_col="Country")
d=pd.concat([c1,c2],axis=1)
print(d)
```

<!-- #region slideshow={"slide_type": "slide"} -->
## Analyser les données

`pandas` permet une analyse rapide de la structure des données:
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df.info()
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df.shape
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df.columns
```

<!-- #region slideshow={"slide_type": "slide"} -->
Ainsi que des outils statistiques intégrés:
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df["Population"].mean()
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df["Population"].median()
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df["Population"].std()
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df["Population"].sum()
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df["Population"].min()
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df["Population"].max()
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df.describe()
```

<!-- #region slideshow={"slide_type": "slide"} -->
On peut également chercher l'indice d'une valeur particulière, par
exemple ici la valeur maximale. La méthode .idxmax() renvoie l'index
correspondant à la première occurrence.
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df['Population'].max()
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df['Population'].idxmax()
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df.loc[df['Population'].idxmax()] ['Capital']
```

<!-- #region slideshow={"slide_type": "slide"} -->
## Extraire des données

Il est possible de faire des tests sur une colonne d'un DataFrame:
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df["Population"]< 1e9
```

Ce test permet ensuite d'extraire les lignes pour lesquelles le test est
vrai:

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df[df["Population"]< 1e9]
```

Remarque: il est possible d'utiliser la méthode `.loc[]` avec une
condition sur une colonne (ex : `df.loc[df.Population<1e9]`)

<!-- #region slideshow={"slide_type": "slide"} -->
Il est possible d'utiliser plusieurs conditions à la fois :
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df[(df.Population<1e9) & (df.Population>1e8)]
```

Attention, il faut utiliser l'opérateur binaire $\&$ et non l'opérateur
logique and :

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df[(df.Population<1e9) and (df.Population>1e8)]
```

Remarque : cela est également le cas lorsque l'on utilise plusieurs
conditions dans un numpy array.

<!-- #region slideshow={"slide_type": "slide"} -->
Opérateurs binaire :

  **Booléen** |   **Binaire**
  ----------------|-------------
  and |           $\&$
  or |            $|$
  not |           $\sim$

Attention, les parenthèses sont obligatoires ! Elles permettent de
contrecarrer l'ordre de préséance des opérateurs binaires sur les
opérateurs conditionnels < et \>.
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df[df.Population<1e9 & df.Population>1e8]
```

<!-- #region slideshow={"slide_type": "slide"} -->
La commande `groupby()` permet de former des groupes qui ont la même
valeur dans une colonne
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
df_fruits = pd.read_csv("data/fruits.csv")    
print(df_fruits)
```

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
color_group = df_fruits.groupby("color")
```

Il est ensuite possible d'extraire des valeurs d'ensemble de ces groupes
de données et générer des nouveaux dataframe.

<!-- #region slideshow={"slide_type": "slide"} -->
Combien de fruits a-t-on par couleur?
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
color_group["color"].count()
```

Quel est le prix total des fruits par groupe de couleur?

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
color_group["price"].sum()
```

<!-- #region slideshow={"slide_type": "slide"} -->
Quel est le prix moyen par couleur?
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
color_group["price"].mean()
```

<!-- #region slideshow={"slide_type": "slide"} -->
## Visualiser les données

Pandas permet aussi de visualiser rapidement les données grâce à la
fonction plot intégrée dans le module:
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
import matplotlib.pyplot as plt
a=color_group["price"].mean()
a.plot(kind="area")
plt.show()
```

Différents types de représentations graphiques sont disponibles:
scatter, hist, box, pie, area\...

<!-- #region slideshow={"slide_type": "slide"} -->
Par exemple en diagramme circulaire :
<!-- #endregion -->

```python codeCellConfig={"lineNumbers": true} slideshow={"slide_type": "-"} tags=["raises-exception"]
import matplotlib.pyplot as plt
s1=pd.Series(df['Capital'])
s2=pd.Series(df['Population'])
s2.plot(kind='pie',autopct='%2.f%%',labels=s1)
plt.show()
```

<!-- #region slideshow={"slide_type": "slide"} -->
## À vos TPs !

1.  Ouvrir un terminal:

    -   soit sur https://jupyterhub.ijclab.in2p3.fr

    -   soit sur un ordinateur du 336

2.  Télécharger la séance d'aujourd'hui:

        methnum fetch L1/Seance10 TONGROUPE

    en remplaçant TONGROUPE par ton numéro de groupe.

3.  Sur un ordinateur du bâtiment 336 uniquement, lancer le jupyter:

        methnum jupyter notebook

4.  Pour soumettre la séance, dans le terminal taper:

        methnum submit L1/Seance10 TONGROUPE
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
Rappel: votre gitlab personnel sert de sauvegarde pour passer vos
documents d'une plateforme à l'autre via les commandes methnum/fetch.


<img src="../scripts/figures/methnum_structure.png" width="100%" />
<!-- #endregion -->
