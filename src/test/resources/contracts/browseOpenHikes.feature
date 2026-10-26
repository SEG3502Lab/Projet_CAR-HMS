# language: fr
Fonctionnalité: browseOpenHikes
  Commande : browseOpenHikes(query: BrowseOpenHikesQuery): List<HikeSummary>
  Toute personne, connectée ou non, consulte les randonnées ouvertes,
  avec des filtres facultatifs. Les résultats sont triés par date de départ.
  Paramètres :
    - trailName : nom du sentier (facultatif)
    - date : date de la randonnée (facultatif)
    - difficulty : difficulté CCN (facultatif)

  Contexte:
    Étant donné les randonnées suivantes :
      | hikeId      | titre                          | sentier              | difficulté | départ           | statut  |
      | H-2027-0012 | Lever du soleil à Luskville    | Sentier de Luskville | difficile  | 2027-06-12T07:00 | ouverte |
      | H-2027-0015 | Balade du Lac-Pink             | Sentier du Lac-Pink  | facile     | 2027-06-05T10:00 | ouverte |
      | H-2027-0018 | Boucle du mont King            | Sentier du mont King | modéré     | 2027-06-12T13:00 | ouverte |
      | H-2027-0020 | Luskville en après-midi        | Sentier de Luskville | difficile  | 2027-06-19T13:00 | annulée |
      | H-2027-0022 | Lac-Pink au crépuscule         | Sentier du Lac-Pink  | facile     | 2027-06-08T19:00 | fermée  |
    Et nous sommes le 2027-06-01T12:00

  Scénario: Consultation sans filtre par un visiteur non connecté
    Étant donné aucun utilisateur n'est connecté
    Quand on consulte les randonnées ouvertes sans filtre
    Alors les randonnées retournées sont, dans l'ordre : H-2027-0015, H-2027-0012, H-2027-0018
    Et chaque résultat indique le titre, le sentier, la difficulté, le départ et les places restantes

  Scénario: Consultation filtrée par sentier
    Quand on consulte les randonnées ouvertes pour le sentier "Sentier de Luskville"
    Alors les randonnées retournées sont, dans l'ordre : H-2027-0012

  Scénario: Consultation filtrée par date
    Quand on consulte les randonnées ouvertes pour la date 2027-06-12
    Alors les randonnées retournées sont, dans l'ordre : H-2027-0012, H-2027-0018

  Scénario: Consultation filtrée par difficulté
    Quand on consulte les randonnées ouvertes de difficulté "facile"
    Alors les randonnées retournées sont, dans l'ordre : H-2027-0015

  Scénario: Aucune randonnée ne correspond aux filtres
    Quand on consulte les randonnées ouvertes pour le sentier "Sentier du Lac-Pink" et la date 2027-06-12
    Alors aucune randonnée n'est retournée
