# Segmentation d'images de microscopie cellulaire

Projet universitaire de segmentation binaire d'images de microscopie, realise
avec TensorFlow/Keras. Deux jeux de suivi de cellules sont etudies :

- `DIC-C2DH-HeLa` : microscopie a contraste interferentiel differentiel.
- `PhC-C2DH-U373` : microscopie a contraste de phase.

Les notebooks comparent plusieurs architectures et methodes :
U-Net original et variantes, ResNet-50, CNN sequentiel, DeepLabV3+, Random
Forest et XGBoost.

> Ce depot est un projet de recherche et d'apprentissage. Il ne constitue pas
> un outil medical et ne doit pas etre utilise pour un diagnostic.

## Contenu

```text
UNet_&_CNN/
├── data/
│   ├── DIC-C2DH-HeLa_train.zip
│   ├── DIC-C2DH-HeLa_test.zip
│   ├── PhC-C2DH-U373_train.zip
│   ├── PhC-C2DH-U373_test.zip
│   └── README.md
├── Rendu_final_DIC.ipynb
├── Rendu_final_PhC.ipynb
├── Unet.png
├── UNet.pdf
├── requirements.txt
├── LICENSE
└── README.md
```

- `Rendu_final_DIC.ipynb` : experience complete sur `DIC-C2DH-HeLa`.
- `Rendu_final_PhC.ipynb` : experience complete sur `PhC-C2DH-U373`.
- `Unet.png` et `UNet.pdf` : ressources visuelles sur l'architecture U-Net.
- `data/README.md` : description des donnees incluses dans le depot.

## Methodologie

Les deux notebooks utilisent une graine fixe (`SEED = 42`) et le decoupage :

- 64 % pour l'entrainement ;
- 16 % pour la validation ;
- 20 % pour le test.

Le pipeline comprend le chargement des archives, le redimensionnement et le
paddage des images, une normalisation z-score calculee uniquement sur
l'entrainement, une augmentation des donnees, puis l'entrainement et
l'evaluation des modeles.

Les sorties probabilistes sont evaluees avec : exactitude, precision, rappel,
Dice/F1, IoU, AUC ROC, AUC precision-rappel et separation des cellules du fond.

Les variantes etudiees comprennent :

- U-Net original, simplifie, avec padding et avec ASPP ;
- ResNet-50 et ses variantes parametrees ;
- CNN sequentiel ;
- DeepLabV3+ ;
- Random Forest ;
- XGBoost.

## Prerequis

- Windows 10/11 64 bits recommande ;
- Python 3.10.11 ;
- plusieurs gigaoctets d'espace disque et de memoire vive ;
- une connexion Internet pour installer les dependances ;
- une carte graphique optionnelle pour l'execution DirectML sous Windows.

TensorFlow 2.10 impose Python 3.10 sur cette configuration. La liste complete
des bibliotheques se trouve dans `requirements.txt`.

## Installation

Depuis la racine du dossier, dans PowerShell :

```powershell
py -3.10 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m ipykernel install --sys-prefix --name unet-microscopy --display-name "Python (U-Net Microscopy)"
python -m jupyterlab
```

Si l'activation de PowerShell est bloquee, utiliser directement les executables
de l'environnement :

```powershell
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe -m jupyterlab
```

Dans VS Code, selectionner l'interpreteur
`.\.venv\Scripts\python.exe` et le noyau **Python (U-Net Microscopy)**.
Verifier l'environnement actif dans une cellule :

```python
import sys
print(sys.executable)
```

## GPU AMD sous Windows

L'environnement utilise `tensorflow-cpu==2.10.0` avec
`tensorflow-directml-plugin==0.4.0.dev230202`. Ce plugin est limite a Python
3.10 et certaines operations TensorFlow peuvent ne pas etre prises en charge.

Verifier TensorFlow et la detection du GPU DirectML :

```python
import tensorflow as tf

print("TensorFlow :", tf.__version__)
print("GPU :", tf.config.list_physical_devices("GPU"))
assert tf.config.list_physical_devices("GPU"), "GPU DirectML non detecte"
```

Si aucun GPU n'est detecte, verifier les pilotes AMD, redemarrer le noyau puis
relancer la verification. La compatibilite depend aussi des operations utilisees
par les notebooks.

## Utilisation des notebooks

Ouvrir `Rendu_final_DIC.ipynb` ou `Rendu_final_PhC.ipynb`, choisir le noyau
Python configure ci-dessus, puis executer les cellules dans l'ordre. Les
archives d'entree sont recherchees dans `./data`.

Chaque notebook :

1. charge et decoupe les donnees ;
2. applique les transformations et l'augmentation ;
3. construit et entraine les modeles ;
4. sauvegarde les metriques, courbes et exemples de predictions dans ses sorties ;
5. compare les variantes a la fin du notebook.

## Donnees

Les archives `DIC-C2DH-HeLa_*`, `PhC-C2DH-U373_*` sont deja presentes dans `data/`. Consulter
[`data/README.md`](data/README.md) avant toute redistribution ou modification.

Ne publiez pas de donnees identifiantes, non anonymisees ou dont la licence
interdit la redistribution.

## Reproductibilite et limites

- Les deux notebooks enregistrent les sorties obtenues lors des essais.
- La graine fixe améliore la reproductibilité, mais ne remplace pas plusieurs
  executions independantes ni une evaluation plus large.
- Les résultats doivent etre interpretes avec la répartition des classes, dont
  les cellules peuvent être minoritaires dans les images.
- Les performances experimentales ne constituent pas une validation clinique.

## Licence

Ce projet est distribué sous licence MIT. Voir [`LICENSE`](LICENSE).
