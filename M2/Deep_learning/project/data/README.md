# Données du projet

Aucun jeu de données n'est distribué avec le dépôt. Placez les données obtenues
et autorisées localement dans ce dossier, par exemple dans `raw/`, puis ajoutez
au projet les instructions documentant leur provenance, leur licence et leur
prétraitement.

Les sous-dossiers `raw/` et `processed/` sont ignorés par Git afin d'éviter de
publier accidentellement des images médicales, des données personnelles ou des
fichiers volumineux. Vérifiez les règles de consentement, d'anonymisation et de
redistribution avant toute utilisation ou publication.

## Jeu de données `membrane`

Le dossier `raw/membrane/` contient les fichiers téléchargés depuis
[`zhixuhao/unet/data/membrane`](https://github.com/zhixuhao/unet/tree/master/data/membrane).
Il comprend des images et masques de membranes cellulaires (microscopie), et
non des mammographies : il ne correspond donc pas directement au sujet du
projet.

Le dépôt source indique une licence MIT, mais cela ne garantit pas que les
images elles-mêmes soient couvertes par cette licence. Vérifier les conditions
propres aux données avant toute redistribution. Aucun prétraitement n'a été
appliqué.
