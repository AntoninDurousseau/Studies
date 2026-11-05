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
- Python 3.12
- Une connexion Internet pour installer les dépendances

TensorFlow et PyTorch sont tous deux importés par le notebook. Leur installation
peut prendre du temps et occuper plusieurs gigaoctets. L'environnement virtuel
est local à ce projet et ne doit pas être publié sur GitHub.

## Installation (PowerShell)

Depuis la racine de ce dossier :

```powershell
py -3.12 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m ipykernel install --sys-prefix --name unet-mammography --display-name "Python (U-Net mammography)"
```

Si PowerShell bloque l'activation du script, vous pouvez appeler directement
les exécutables de l'environnement, par exemple
`.\.venv\Scripts\python.exe -m pip install -r requirements.txt`.

Lancer ensuite JupyterLab depuis l'environnement :

```powershell
.\.venv\Scripts\jupyter-lab.exe
```

Dans le notebook, choisir le noyau **Python (U-Net mammography)**.

Dans VS Code, ouvrir ce dossier comme espace de travail. Le réglage versionné
`.vscode/settings.json` indique le venv du projet comme interpréteur Python par
défaut. Pour le notebook déjà ouvert, utiliser **Select Kernel** en haut à
droite, choisir **Python (U-Net mammography)**, puis redémarrer le noyau. Pour
vérifier l'interpréteur actif dans une cellule, exécuter `import sys;
print(sys.executable)` : le chemin doit se terminer par
`project\\.venv\\Scripts\\python.exe`.

## GPU AMD sous Windows

L'installation TensorFlow standard de ce projet (Python 3.12 et TensorFlow
récent) n'utilise pas le GPU AMD sous Windows natif. Microsoft documente un
plugin DirectML pour AMD, mais ce plugin est abandonné. Sa documentation limite
Python à la version 3.10 et impose `tensorflow-cpu==2.10`. Python 3.10.11 est
donc la version la plus récente utilisable avec cette voie, pas la version la
plus récente de Python en général. La Radeon RX 6750 XT est une carte DirectX 12,
mais cela ne garantit pas la compatibilité de chaque opération du modèle.

Le venv standard `.venv` reste en Python 3.12. Un venv ne peut pas changer de
version Python après sa création ; pour tester DirectML, créer un environnement
isolé `.venv-amd` et installer les dépendances séparément. Ne pas utiliser
`requirements.txt`, qui demande un TensorFlow trop récent pour le plugin :

```powershell
py -3.10 -m venv .venv-amd
.\.venv-amd\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install "numpy<1.24" "pandas>=2.2,<3" "matplotlib>=3.8,<4" "seaborn>=0.13,<1" tensorflow-cpu==2.10 tensorflow-directml-plugin "torch>=2.2,<3" "ipykernel>=6.29,<7"
python -m ipykernel install --user --name unet-amd --display-name "Python (U-Net AMD DirectML)"
```

Sélectionner le noyau **Python (U-Net AMD DirectML)** dans le notebook, puis le
redémarrer. Vérifier la version, le GPU détecté et l'exécution d'une opération :

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
