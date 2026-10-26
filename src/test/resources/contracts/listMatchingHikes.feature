# language: fr
Fonctionnalité: listMatchingHikes
  Commande : listMatchingHikes(query: ListMatchingHikesQuery): List<HikeSummary>
  Un randonneur connecté voit les randonnées ouvertes qui correspondent à son niveau.
  Règle de niveau : rang(difficulté du sentier) <= rang(niveau du randonneur) + 1
  (débutant/facile = 1, intermédiaire/modéré = 2, avancé/difficile = 3, expert/très difficile = 4).
  Paramètres :
    - hikerEmail : courriel du randonneur connecté

  Contexte:
    Étant donné les randonnées ouvertes suivantes :
      | hikeId      | sentier                | difficulté     | départ           |
      | H-2027-0015 | Sentier du Lac-Pink    | facile         | 2027-06-05T10:00 |
      | H-2027-0012 | Sentier de Luskville   | difficile      | 2027-06-12T07:00 |
      | H-2027-0018 | Sentier du mont King   | modéré         | 2027-06-12T13:00 |
      | H-2027-0025 | Crête de l'escarpement | très difficile | 2027-07-17T07:00 |
    Et les randonneurs suivants :
      | courriel                   | niveau        |
      | amira.haddad@courriel.ca   | débutant      |
      | julien.gagnon@courriel.ca  | intermédiaire |
      | lucas.roy@courriel.ca      | expert        |
    Et nous sommes le 2027-06-01T12:00

  Scénario: Randonnées correspondant au niveau débutant
    Étant donné "amira.haddad@courriel.ca" est connectée
    Quand "amira.haddad@courriel.ca" demande les randonnées qui lui correspondent
    Alors les randonnées retournées sont, dans l'ordre : H-2027-0015, H-2027-0018

  Scénario: Randonnées correspondant au niveau intermédiaire
    Étant donné "julien.gagnon@courriel.ca" est connecté
    Quand "julien.gagnon@courriel.ca" demande les randonnées qui lui correspondent
    Alors les randonnées retournées sont, dans l'ordre : H-2027-0015, H-2027-0012, H-2027-0018

  Scénario: Randonnées correspondant au niveau expert
    Étant donné "lucas.roy@courriel.ca" est connecté
    Quand "lucas.roy@courriel.ca" demande les randonnées qui lui correspondent
    Alors les randonnées retournées sont, dans l'ordre : H-2027-0015, H-2027-0012, H-2027-0018, H-2027-0025

  Scénario: Échec si le randonneur n'est pas connecté
    Étant donné aucun utilisateur n'est connecté
    Quand un visiteur demande les randonnées correspondant à "julien.gagnon@courriel.ca"
    Alors la demande est refusée avec le motif "connexion requise"
