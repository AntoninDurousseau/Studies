# Segmentation d'images mammographiques par U-Net

Projet universitaire de deep learning consacré à la segmentation d'images
mammographiques. L'objectif est d'étudier l'architecture U-Net et de comparer,
à terme, ses performances à celles d'architectures convolutionnelles plus
simples.

> **État du projet : prototype en cours.** Le notebook présente le contexte et
> l'architecture envisagée, mais le jeu de données, le pipeline de préparation,
> l'implémentation complète du modèle, l'entraînement et les résultats ne sont
> pas encore fournis. Ce dépôt ne constitue pas un outil de diagnostic.

## Contenu

```text
project/
├── data/
│   └── README.md
├── Projet_UNet.ipynb
├── Unet.png
├── UNet.pdf
├── requirements.txt
└── README.md
```

- `Projet_UNet.ipynb` : présentation et espace de travail du projet.
- `Unet.png` et `UNet.pdf` : supports d'architecture présents dans le dossier.
- `data/README.md` : consignes pour fournir localement les données.

## Prérequis

- Windows 10/11 64 bits
- Python 3.10.11
- Une connexion Internet pour installer les dépendances

L'environnement `.venv` contient les bibliothèques utilisées par les notebooks,
dont TensorFlow avec DirectML, PyTorch, SciPy et les outils de lecture d'images.
Son installation peut prendre du temps et occuper plusieurs gigaoctets. Il est
local à ce projet et ne doit pas être publié sur GitHub.

## Installation (PowerShell)

Depuis la racine de ce dossier :

```powershell
py -3.10 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m ipykernel install --sys-prefix --name unet-mammography --display-name "Python (U-Net DirectML)"
```

Si PowerShell bloque l'activation du script, vous pouvez appeler directement
les exécutables de l'environnement, par exemple
`.\.venv\Scripts\python.exe -m pip install -r requirements.txt`.

Lancer ensuite JupyterLab depuis l'environnement :

```powershell
python -m jupyterlab
```

Dans le notebook, choisir le noyau **Python (U-Net DirectML)**.

Dans VS Code, sélectionner l'interpréteur `.\.venv\Scripts\python.exe` et le
noyau **Python (U-Net DirectML)** pour le notebook. Redémarrer le noyau après
le changement. Pour vérifier l'interpréteur actif dans une cellule, exécuter
`import sys; print(sys.executable)` : le chemin doit se terminer par
`UNet_&_CNN\\.venv\\Scripts\\python.exe`.

## GPU AMD sous Windows

L'environnement utilise `tensorflow-cpu==2.10.0` avec le plugin DirectML
Microsoft. Ce plugin est abandonné et limité à Python 3.10 ; certaines
opérations peuvent ne pas être prises en charge. La Radeon RX 6750 XT est une
carte DirectX 12, mais cela ne garantit pas la compatibilité de chaque
opération.

Vérifier la version, le GPU détecté et l'exécution d'une opération dans le
noyau sélectionné :

```python
import tensorflow as tf
print(tf.__version__)
gpus = tf.config.list_physical_devices("GPU")
print(gpus)
assert gpus, "TensorFlow ne détecte pas de GPU DirectML"

with tf.device("/GPU:0"):
    result = tf.reduce_sum(tf.random.normal((1024, 1024)))
print(result)
```

Si le test échoue, redémarrer le noyau et vérifier le pilote AMD et le résultat
de `tf.config.list_physical_devices("GPU")`. Le plugin est ancien et certaines
opérations peuvent ne pas être prises en charge. La RX 6750 XT ne figure pas
dans la liste actuelle des GPU Radeon officiellement pris en charge par ROCm ;
passer simplement à WSL2 ne garantit donc pas l'accélération TensorFlow avec
cette carte.

## Données

Aucune donnée n'est incluse dans ce dépôt. Consulter [`data/README.md`](data/README.md)
avant d'ajouter un jeu de données. Ne jamais publier de données médicales
identifiantes, de données dont la licence ne permet pas la redistribution, ni
de données non autorisées.

## Reproductibilité et limites

- Le notebook est un travail en cours et ne fournit pas encore d'expérience
  reproductible de bout en bout.
- Aucune métrique, performance ou conclusion clinique n'est revendiquée.
- Toute future évaluation devra documenter la provenance et la licence des
  données, les prétraitements, la séparation des données (au niveau des
  patientes), les paramètres d'entraînement et les graines aléatoires.
- Les performances de modèles expérimentaux ne remplacent pas une évaluation
  clinique ou l'avis d'un professionnel de santé.

## Licence

Ce projet est distribué sous licence MIT. Voir [`LICENSE`](LICENSE).
