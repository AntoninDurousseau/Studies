---
jupytext:
  formats: ipynb,md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.13.6
kernelspec:
  display_name: Python 3 (ipykernel)
  language: python
  name: python3
---

Merci de **ne pas modifier** le nom de ce notebook (même pour y inclure son nom).

Quelques conseils:
- pour exécutez une cellule, cliquez sur le bouton *Exécuter* ci-dessus ou tapez **Shift+Enter**
- si l'exécution d'une cellule prend trop de temps, sélectionner dans le menu ci-dessus *Noyau/Interrompre*
- en cas de très gros plantage *Noyau/Redémarrer*
- **sauvegardez régulièrement vos réponses** en cliquant sur l'icone disquette ci-dessus à gauche, ou *Fichier/Créer une nouvelle sauvegarde*

----------------------------------------------------------------------------

+++ {"deletable": false, "editable": false, "nbgrader": {"cell_type": "markdown", "checksum": "e13e2e2b8c73b0838b31ef2fb4eb0177", "grade": false, "grade_id": "cell-5a181db2aa8e3a0d", "locked": true, "schema_version": 3, "solution": false}}

# TD 7: Ajustement de données

## Introduction

On considère deux séries de données `xdata=[0.1, 0.2, 0.3, 0.4, 0.5, 0.7, 0.8, 0.9, 1]` et `ydata=[0.3, 0.7, 0.9, 1.1, 1.6, 2.3, 2.2, 2.8, 3.1`. 
- Représenter graphiquement les points `(xdata, ydata)`.
- Effectuer une régression linéaire de `ydata` en fonction de `xdata`: tracer la droite de regression linéaire $y=ax+b$ sur le graphe précédent. 
- Afficher $a$, $b$ ainsi que la valeur du coefficient de régression $R^2$.

Conclusion: est-ce que le modèle affine choisi traduit bien les variations de `ydata` en fonction de `xdata` ?

```{code-cell} ipython3
---
deletable: false
nbgrader:
  cell_type: code
  checksum: 0be4e45c733cc0a54767afaabb055781
  grade: true
  grade_id: cell-9b1161510c002062
  locked: false
  points: 0
  schema_version: 3
  solution: true
---
import numpy
import matplotlib.pyplot as plt
from scipy import stats


xdata = numpy.array([0.1, 0.2, 0.3, 0.4, 0.5, 0.7, 0.8, 0.9, 1])
ydata = numpy.array([0.3, 0.7, 0.9, 1.1, 1.6, 2.3, 2.2, 2.8, 3.1])

a,b,r,p,stderr = stats.linregress(xdata, ydata)
                                  
plt.figure()
plt.plot(xdata, ydata ,marker='o', linestyle='None')
plt.plot(xdata, a*xdata+b, label="a = "+str(a)+"\nb = "+str(b)+"\nr = "+str(r))
plt.xlabel('xdata', fontsize=14)
plt.ylabel('ydata', fontsize=14)
plt.grid()
plt.legend()
plt.show()
```

+++ {"deletable": false, "editable": false, "nbgrader": {"cell_type": "markdown", "checksum": "429cde237215bcb10fda79f631bd0aef", "grade": false, "grade_id": "cell-f37c0c29ed050ed3", "locked": true, "schema_version": 3, "solution": false}}

## Exercice 1: Régression linéaire

Pour comprendre dans quelles situations un modèle linéaire $y=ax+b$ résume de manière pertinente la relation entre une série de données et une autre, nous allons générer nous-même des jeux de données puis effectuer une régression linéaire dessus. 

Partons d'un tableau $x$ de nombres réels $x_0,x_1,x_2...x_i...x_N$ compris entre 0 et 10 ($N$=100 valeurs par exemple). Nous allons créer un tableau $y$ de réels $y_i =ax_i+b+\epsilon_i$ où $\epsilon_i$ est un nombre aléatoire.    

Ce nombre aléatoire $\epsilon_i$ sera généré à l'aide de la fonction `np.random.norma` (voir script ci-dessous).

```{code-cell} ipython3
---
deletable: false
editable: false
nbgrader:
  cell_type: code
  checksum: 65d9c54c57ba87f1811865db4136fc72
  grade: false
  grade_id: cell-865a90b45603ea16
  locked: true
  schema_version: 3
  solution: false
  task: false
---
import numpy as np
import matplotlib.pyplot as plt

moyenne=0.0
sigma=1.0
N=100
epsilon=np.random.normal(moyenne,sigma,N)

plt.figure()
plt.title('100 valeurs aléatoires epsilon obtenues')
plt.plot(epsilon,marker='+',linestyle='None')
plt.show()
```

+++ {"deletable": false, "editable": false, "nbgrader": {"cell_type": "markdown", "checksum": "56863e82d29b66723823df6f7a7703f8", "grade": false, "grade_id": "cell-bf53cba95d02a9ff", "locked": true, "schema_version": 3, "solution": false, "task": false}}

Le programme ci-desous génère des jeux de données $x$ et $y$ tels que $y_i =ax_i+b+\epsilon_i$ où $\epsilon_i$ est un nombre aléatoire généré à l'aide de la fonction `np.random.normal`. Il affiche les données $x$ et $y$ ainsi qu'un histogramme des valeurs $\epsilon_i$. 
- Faire varier les paramètres `moyenne` et `sigma` de la fonction `np.random.normal` pour en comprendre le fonctionnement.

```{code-cell} ipython3
---
deletable: false
editable: false
nbgrader:
  cell_type: code
  checksum: c5b15dac760e9b8cf81e55b9b3b73eed
  grade: false
  grade_id: cell-8dfb2115f8eb5759
  locked: true
  schema_version: 3
  solution: false
  task: false
---
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats


#Jeu de données simulées
a=10
b=2
sigma=4
moyenne=0

xdata = np.linspace(0,10,100)
epsilon = np.random.normal(moyenne,sigma,xdata.size)
ydata=a*xdata+b+epsilon

fig, ax = plt.subplots(1, 2, figsize=(12,6))
ax[0].errorbar(xdata,ydata,marker='+',linestyle='None')
ax[0].set_xlabel('x')
ax[0].set_ylabel('y')
ax[1].hist(epsilon, bins=int(np.sqrt(xdata.size)))
ax[1].set_xlabel('epsilon')
ax[1].set_ylabel('occurences')
plt.show()
```

+++ {"deletable": false, "editable": false, "nbgrader": {"cell_type": "markdown", "checksum": "267adf201e84f6fc8a6b49b8e730964d", "grade": false, "grade_id": "cell-96352ee2d5ac8d9f", "locked": true, "schema_version": 3, "solution": false}}

- Effectuer une regression linéaire sur ces données. 
- Comment varie le coefficient $R^2$ lorsque l'amplitude `sigma` de fluctuation de $y$ augmente ?

```{code-cell} ipython3
---
deletable: false
nbgrader:
  cell_type: code
  checksum: 7ea45ed24176608bdfbc9958040dc0c6
  grade: true
  grade_id: cell-84b7a3755a28f189
  locked: false
  points: 0
  schema_version: 3
  solution: true
---
import numpy
import matplotlib.pyplot as plt
from scipy import stats

#Jeu de données simulées
a=10
b=2
sigma=4
moyenne=0

xdata = np.linspace(0,10,100)
epsilon = np.random.normal(moyenne,sigma,xdata.size)
ydata=a*xdata+b+epsilon

a,b,r,p,stderr = stats.linregress(xdata, ydata)
                                  
plt.figure()
plt.plot(xdata, ydata ,marker='+', linestyle='None')
plt.plot(xdata, a*xdata+b, label="a = "+str(a)+"\nb = "+str(b)+"\nr = "+str(r))
plt.xlabel('xdata', fontsize=14)
plt.ylabel('ydata', fontsize=14)
plt.grid()
plt.legend()
plt.show()
```

+++ {"deletable": false, "editable": false, "nbgrader": {"cell_type": "markdown", "checksum": "73f7c905f798af817b95e78d7f77586f", "grade": false, "grade_id": "cell-aedc907b17cad2dc", "locked": true, "schema_version": 3, "solution": false, "task": false}}

## Exercice 2: Exploitation de mesures expérimentales

Dans cet exercice nous allons reprendre les mesures du TP1 de l'UE Phys102. Si vous disposez de vos propres mesures, essayez les vôtres ! Il s'agit de mesurer l'indice de réfraction de l'altuglas à partir de la mesure des angles incidents et réfractés ci-dessous:

\begin{array}{c|cccccccccccc}  \hline \hline
\theta_i (°) & 0 & 10 & 15 & 20 & 25 & 30 & 35 & 40 & 45 & 50 & 55 & 60 \\ 
\theta_r (°) & 0 & 6  & 10 & 12 & 15 & 19 & 22 & 23 & 28 & 30 & 33 & 34 \\
\Delta \theta_i (°) & 0.5 & 0.5 & 1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 \\
\Delta \theta_r (°) & 1 & 1 & 1 & 1 & 1 & 1.5 & 1.5 & 1.5 & 1.5 & 1.5 & 2 & 2 \\
\hline \hline
\end{array}

Le premier milieu est l'air ambiant, le second l'altuglas. On suppose que l'évolution de l'angle de réfraction $\theta_r$ avec l'angle d'incidence $\theta_i$ suit la loi de Descartes : 

$$ n \sin(\theta_r) = \sin(\theta_i), $$
avec $n$ l'indice de réfraction inconnu de l'altuglas.

- Ecrire une fonction loi_refraction(theta_i, n) qui retourne la valeur de $\theta_r$ en degré à partir de l'indice n de l'altuglas et $\theta_i$ l'angle d'incidence en degré également.

```{code-cell} ipython3
---
deletable: false
nbgrader:
  cell_type: code
  checksum: 70e3f1da8397a677648caba02d3ce22a
  grade: true
  grade_id: cell-1ddb28ece742e7a0
  locked: false
  points: 0
  schema_version: 3
  solution: true
  task: false
---
import numpy as np
from math import pi

def loi_refraction(theta_i,n):
    return (np.arcsin(np.sin(theta_i*pi/180)/n) * 180/pi)
```

+++ {"deletable": false, "editable": false, "nbgrader": {"cell_type": "markdown", "checksum": "53a80d98a70492b70db5908f862cf6ac", "grade": false, "grade_id": "cell-0bdd144f75ac31ab", "locked": true, "schema_version": 3, "solution": false}}

- Ajuster la loi de Descartes aux données expérimentales à l'aide de [`curve_fit`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.curve_fit.html#scipy.optimize.curve_fit) , et représenter sur un même graphique les données, leurs incertitudes et le modèle ajusté.
- Que vaut l'indice de l'atluglas et quel est son incertitude ? Qu'en déduisez-vous si on suppose qu'en réalité $n_{\text{altuglas}}=1.57$ ?

```{code-cell} ipython3
---
deletable: false
nbgrader:
  cell_type: code
  checksum: b77d85fe0dd1b865bb2658c955dfa14c
  grade: true
  grade_id: cell-79c922a5216ed2d9
  locked: false
  points: 0
  schema_version: 3
  solution: true
---
from scipy.optimize import curve_fit

xdata = np.array([0,10,15,20,25,30,35,40,45,50,55,60])
ydata = np.array([0,6,10,12,15,19,22,23,28,30,33,34])
sigma_y = np.array([1,1,1,1,1,1.5,1.5,1.5,1.5,1.5,2,2])
sigma_x = np.array([0.5,0.5,1,1,1,1,1,1,1,1,1,1])
p0 = np.array([1000000])

param,pcov = curve_fit(loi_refraction,xdata,ydata,p0,sigma_y)

plt.figure()
plt.errorbar(xdata, ydata, xerr=sigma_x, yerr=sigma_y, marker='+', color='r', linestyle='None')
plt.plot(xdata, loi_refraction(xdata,param[0]), label="a="+str(a)+"\nb="+str(b))
plt.xlabel('theta_i', fontsize=14)
plt.ylabel('theta_r', fontsize=14)
plt.grid()
plt.legend()
plt.show()

print(param[0])
```

+++ {"deletable": false, "editable": false, "nbgrader": {"cell_type": "markdown", "checksum": "3db82f2ad0c63fe969a869a23d9878e4", "grade": false, "grade_id": "cell-c578f8b45095e9c7", "locked": true, "schema_version": 3, "solution": false}}

 - Calculer les résidus normalisés aux incertitudes  $\frac{y_i-f(x_i)}{\sigma_i}$, les représenter sous forme d'un graphique en fonction de $i$ et sous forme d'histogramme.
- Que vaut le $\chi^2$ réduit ? Est-il bon ou mauvais ?

```{code-cell} ipython3
---
deletable: false
nbgrader:
  cell_type: code
  checksum: 72069a34fb72982f667b63e7e3d9bcf2
  grade: true
  grade_id: cell-ec6c2c298a0203b3
  locked: false
  points: 0
  schema_version: 3
  solution: true
---

```

+++ {"deletable": false, "editable": false, "nbgrader": {"cell_type": "markdown", "checksum": "29763ea5c23cb2f42b5287d65e6849e2", "grade": false, "grade_id": "cell-dce5a0f1afee76b1", "locked": true, "schema_version": 3, "solution": false, "task": false}}

Maintenant imagninons que Descartes ne soit jamais né, et que nous soyons toujours ignorants de la véritable loi de la réfraction. On souhaite toutefois décrire nos données, et pour cela, vu la courbe expérimentale, on peut penser à une fonction polynomiale, de degré 2 probablement. 
- Dans la fonction `ajustement_polynome` ci-dessous, par quoi doit-on remplacer les ... pour ajuster un polynome de degré $k$ aux données, pour calculer les résidus et le $\chi^2$ réduit? La convention pour les poids dans `np.polyfit` (https://docs.scipy.org/doc/numpy/reference/generated/numpy.polyfit.html) est $w_i = 1/\sigma_i$, et on donnera comme argument `cov='unscaled'`. Un exemple d'exécution est lancé pour un polynôme de degré 1 en bas de la cellule.

```{code-cell} ipython3
def ajustement_polynome(degre):
    print("Ajustement d'un polynome de degré",degre)
    popt, pcov = np.polyfit(..., ..., deg=..., w=..., cov='unscaled')

    print("Coefficients du polynome:",popt)
    #print(pcov)

    r_fit = np.polyval(popt, i_data)

    plt.figure(1)
    plt.errorbar(i_data, r_data, xerr=di_data, yerr=dr_data, marker='o',linestyle='None')
    plt.plot(i_data, r_fit)
    plt.xlabel('i [$\degree$]')
    plt.ylabel('r [$\degree$]')
    plt.show()

    # Regression lineaire.
    residus=...
    chi2=0.0
    for res in residus:
        chi2 += ...
    chi2_reduit = chi2 / ...
    print('Chi2 réduit:', chi2_reduit)

ajustement_polynome(1)
```

+++ {"deletable": false, "editable": false, "nbgrader": {"cell_type": "markdown", "checksum": "b5113703f9390a32d263f47502220f3a", "grade": false, "grade_id": "cell-8453eccfefc21048", "locked": true, "schema_version": 3, "solution": false, "task": false}}

- Ecrire une boucle qui utlise la fonction `ajustement_polynome` et fait varier le degré du polynôme ajusté.

```{code-cell} ipython3
---
deletable: false
nbgrader:
  cell_type: code
  checksum: 4627a4c5143f22ef0dc2e554e936b342
  grade: true
  grade_id: cell-4687a27a22c74372
  locked: false
  points: 0
  schema_version: 3
  solution: true
---
#LA REPONSE ICI
```

+++ {"deletable": false, "editable": false, "nbgrader": {"cell_type": "markdown", "checksum": "a4117a1e40bc7d07123a422b45b3bb16", "grade": false, "grade_id": "cell-de5e7e9e6028611b", "locked": true, "schema_version": 3, "solution": false}}

- Qu'en déduisez-vous ? Un modèle polynomial est-il adapté et si oui lequel ? Vaut-il mieux un degré plus élevé, un degré plus faible, intermédiaire ?

```{code-cell} ipython3
---
deletable: false
nbgrader:
  cell_type: code
  checksum: 576c71bfdffc7b57a58fa15e296e3175
  grade: true
  grade_id: cell-f62d0bf7f7cc8ba8
  locked: false
  points: 0
  schema_version: 3
  solution: true
---
#LA REPONSE ICI
```

+++ {"deletable": false, "editable": false, "nbgrader": {"cell_type": "markdown", "checksum": "d691d275079763ab858b25225ad7bc99", "grade": false, "grade_id": "cell-66b0586490637df7", "locked": true, "schema_version": 3, "solution": false, "task": false}}

## Exercice 3: Spectre solaire 

Le fichier `data/solar_spectrum.csv` contient des données permettant de reconstituer le spectre de la lumière émise par le soleil. La première colonne est la longueur d'onde $\lambda$ en nm, la seconde est l'irradiance spectrale en $W.m^{-2}.nm^{-1}$ correspondant à cette longueur d'onde.


On donne le spectre du corps noir:

$$ E(\lambda)=\frac{A}{\lambda^5} \frac{1}{e^{hc/(\lambda k_B T)}-1} (W.m^{-2}.nm^{-1})$$ 

- $E(\lambda)$ est l'irradiance spectrale du corps noir
- $\lambda$ est la longueur d'onde de la lumière
- $A$ est une constante
- $h$ est la constante de Planck
- $k_B$ la constante de Boltzmann
- $c$ la vitesse de la lumière
- $T$ la température du corps noir. 

Peut-on modéliser le spectre du Soleil par un spectre de corps noir, et si oui, quelle est la température $T$ de ce corps noir ?   
- Charger le fichier de données avec `np.loadtxt`. Préalablement il faudra taper la commande : f=open('data/solar_spectrum.csv','r')
- A l'aide de ces données, créer deux arrays contenant les longueurs d'ondes et l'irradiance.
- Créer une fonction `planck_lambda(lbd, A, T)` représentant un spectre de corps noir en fonction de `lbd` la longueur d'onde, `A` une constante et `T` la température. On trouvera la valeur des constantes fondamentales sur Internet.
- Ajuster les données expérimentales avec cette fonction à l'aide de `curve_fit`.
- Quelle est la température du Soleil ?
- Représenter les données et la fonction ajustée sur un même graphique.


Remarque: si la fonction d'ajustement des données par le modèle de corps noir ne converge pas, ou donne des résultats très éloignés des données expérimentales, ne pas hésiter à "aider" l'algorithme en règlant les paramètres initiaux. Par exemple, un ordre de grandeur de $A/\lambda^5$ est la valeur approchée du maximum de la courbe expérimentale. De même, vous pouvez donner comme valeur initiale de $T$ un ordre de grandeur de la température du soleil...

```{code-cell} ipython3
---
deletable: false
nbgrader:
  cell_type: code
  checksum: 52b335c10a1f510281d805289859fcba
  grade: true
  grade_id: cell-894b5474c6fe0c25
  locked: false
  points: 0
  schema_version: 3
  solution: true
  task: false
---
#LA REPONSE ICI
```

```{code-cell} ipython3

```
