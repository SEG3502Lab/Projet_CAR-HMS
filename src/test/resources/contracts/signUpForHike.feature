# language: fr
Fonctionnalité: signUpForHike
  Commande : signUpForHike(query: SignUpForHikeQuery): String
  Un randonneur connecté s'inscrit à une randonnée. L'inscription est confirmée
  s'il reste une place, sinon le randonneur est placé en liste d'attente.
  Règle de niveau : rang(difficulté du sentier) <= rang(niveau du randonneur) + 1
  (débutant/facile = 1, intermédiaire/modéré = 2, avancé/difficile = 3, expert/très difficile = 4).
  Paramètres :
    - hikeId : identifiant de la randonnée
    - hikerEmail : courriel du randonneur connecté
  Retour : l'identifiant de l'inscription créée.

  Contexte:
    Étant donné la randonnée "H-2027-0012" sur le "Sentier de Luskville" (difficile) le 2027-06-12T07:00, de capacité 12, avec le statut "ouverte" et 2 places restantes
    Et les randonneurs suivants :
      | courriel                   | niveau        | adhésion  |
      | julien.gagnon@courriel.ca  | intermédiaire | active    |
      | lucas.roy@courriel.ca      | expert        | active    |
      | amira.haddad@courriel.ca   | débutant      | active    |
      | marc.ouellet@courriel.ca   | avancé        | expirée   |
    Et nous sommes le 2027-06-01T12:00

  Scénario: Inscription confirmée lorsqu'il reste des places
    Étant donné "julien.gagnon@courriel.ca" est connecté
    Quand "julien.gagnon@courriel.ca" s'inscrit à "H-2027-0012"
    Alors un identifiant d'inscription est retourné
    Et l'inscription a le statut "confirmée"
    Et le nombre de places restantes de "H-2027-0012" est 1
    Et la randonnée "H-2027-0012" a toujours le statut "ouverte"
    Et "julien.gagnon@courriel.ca" reçoit un courriel de confirmation

  Scénario: La randonnée devient complète avec la dernière place
    Étant donné la randonnée "H-2027-0012" a 1 place restante
    Et "lucas.roy@courriel.ca" est connecté
    Quand "lucas.roy@courriel.ca" s'inscrit à "H-2027-0012"
    Alors l'inscription a le statut "confirmée"
    Et le nombre de places restantes de "H-2027-0012" est 0
    Et la randonnée "H-2027-0012" a le statut "complète"
    Et la transition vers "complète" est enregistrée avec un horodatage et l'acteur "lucas.roy@courriel.ca"
    Et "lucas.roy@courriel.ca" reçoit un courriel de confirmation

  Scénario: Inscription en liste d'attente lorsque la randonnée est complète
    Étant donné la randonnée "H-2027-0012" a le statut "complète" et 2 randonneurs en liste d'attente
    Et "julien.gagnon@courriel.ca" est connecté
    Quand "julien.gagnon@courriel.ca" s'inscrit à "H-2027-0012"
    Alors un identifiant d'inscription est retourné
    Et l'inscription a le statut "en liste d'attente" à la position 3
    Et "julien.gagnon@courriel.ca" reçoit un courriel indiquant sa position 3 en liste d'attente

  Scénario: Échec si le randonneur n'est pas connecté
    Quand un visiteur non connecté s'inscrit à "H-2027-0012"
    Alors l'inscription est refusée avec le motif "connexion requise"

  Scénario: Échec si l'adhésion n'est pas active
    Étant donné "marc.ouellet@courriel.ca" est connecté
    Quand "marc.ouellet@courriel.ca" s'inscrit à "H-2027-0012"
    Alors l'inscription est refusée avec le motif "adhésion non active"
    Et le nombre de places restantes de "H-2027-0012" est 2

  Scénario: Échec si la randonnée n'est ni ouverte ni complète
    Étant donné la randonnée "H-2027-0012" a le statut "fermée"
    Et "julien.gagnon@courriel.ca" est connecté
    Quand "julien.gagnon@courriel.ca" s'inscrit à "H-2027-0012"
    Alors l'inscription est refusée avec le motif "randonnée non disponible"

  Scénario: Échec si le niveau du randonneur est insuffisant
    Étant donné "amira.haddad@courriel.ca" est connectée
    Quand "amira.haddad@courriel.ca" s'inscrit à "H-2027-0012"
    Alors l'inscription est refusée avec le motif "niveau d'habileté insuffisant"
    Et le nombre de places restantes de "H-2027-0012" est 2

  Scénario: Échec si le randonneur a déjà une inscription active
    Étant donné "julien.gagnon@courriel.ca" a déjà une inscription "confirmée" à "H-2027-0012"
    Et "julien.gagnon@courriel.ca" est connecté
    Quand "julien.gagnon@courriel.ca" s'inscrit à "H-2027-0012"
    Alors l'inscription est refusée avec le motif "inscription déjà active"
    Et "julien.gagnon@courriel.ca" a une seule inscription active à "H-2027-0012"
