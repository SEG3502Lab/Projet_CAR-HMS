# language: fr
Fonctionnalité: createHike
  Commande : createHike(query: CreateHikeQuery): String
  Un organisateur certifié crée une randonnée sur un sentier de la CCN.
  Paramètres :
    - organizerEmail : courriel de l'organisateur connecté
    - title, description : titre et description de la randonnée
    - trailId : identifiant du sentier CCN
    - startDateTime : date et heure de départ
    - expectedDuration : durée prévue
    - registrationDeadline : date limite d'inscription
    - capacity : nombre maximal de participants
  Retour : l'identifiant de la randonnée créée.

  Contexte:
    Étant donné les sentiers CCN suivants :
      | trailId  | nom                         | difficulté     | randonnée permise | saison d'ouverture      |
      | CCN-LUSK | Sentier de Luskville        | difficile      | oui               | 2027-05-01 à 2027-10-31 |
      | CCN-PINK | Sentier du Lac-Pink         | facile         | oui               | 2027-05-01 à 2027-11-15 |
      | CCN-MULV | Sentier du marais Mulvihill | facile         | non               | 2027-05-01 à 2027-10-31 |
      | CCN-EARD | Crête de l'escarpement      | très difficile | oui               | 2027-06-01 à 2027-09-30 |
    Et la randonneuse "claire.tremblay@courriel.ca" est connectée
    Et elle détient la certification d'organisatrice "CERT-2027-0142" de niveau "difficile" valide du 2027-03-01 au 2028-02-29

  Scénario: Création réussie d'une randonnée
    Quand "claire.tremblay@courriel.ca" crée la randonnée suivante :
      | title                | Lever du soleil sur l'escarpement de Luskville |
      | description          | Montée vers le belvédère, rythme soutenu        |
      | trailId              | CCN-LUSK                                        |
      | startDateTime        | 2027-06-12T07:00                                |
      | expectedDuration     | PT4H                                            |
      | registrationDeadline | 2027-06-10T18:00                                |
      | capacity             | 12                                              |
    Alors un identifiant unique de randonnée est retourné
    Et la randonnée existe avec le statut "ouverte"
    Et le nombre de places restantes est 12
    Et l'organisatrice de la randonnée est "claire.tremblay@courriel.ca"
    Et la transition vers "ouverte" est enregistrée avec un horodatage et l'acteur "claire.tremblay@courriel.ca"

  Scénario: Échec si le randonneur n'est pas un organisateur certifié
    Étant donné le randonneur "julien.gagnon@courriel.ca" est connecté et n'a aucune certification
    Quand "julien.gagnon@courriel.ca" crée une randonnée sur "CCN-PINK" le 2027-06-12T09:00 avec une capacité de 10
    Alors la création est refusée avec le motif "organisateur non certifié"
    Et aucune randonnée n'est créée

  Scénario: Échec si la randonnée n'est pas permise sur le sentier
    Quand "claire.tremblay@courriel.ca" crée une randonnée sur "CCN-MULV" le 2027-06-12T09:00 avec une capacité de 10
    Alors la création est refusée avec le motif "randonnée non permise sur ce sentier"
    Et aucune randonnée n'est créée

  Scénario: Échec si la date est hors de la saison d'ouverture du sentier
    Quand "claire.tremblay@courriel.ca" crée une randonnée sur "CCN-LUSK" le 2027-11-20T09:00 avec une capacité de 10
    Alors la création est refusée avec le motif "date hors de la saison d'ouverture"
    Et aucune randonnée n'est créée

  Scénario: Échec si la date limite est plus de 14 jours avant le départ
    Quand "claire.tremblay@courriel.ca" crée une randonnée sur "CCN-LUSK" le 2027-06-30T07:00 avec la date limite 2027-06-10T18:00
    Alors la création est refusée avec le motif "date limite d'inscription invalide"
    Et aucune randonnée n'est créée

  Scénario: Échec si la date limite est après le départ
    Quand "claire.tremblay@courriel.ca" crée une randonnée sur "CCN-LUSK" le 2027-06-12T07:00 avec la date limite 2027-06-12T08:00
    Alors la création est refusée avec le motif "date limite d'inscription invalide"
    Et aucune randonnée n'est créée

  Scénario: Échec si la capacité n'est pas positive
    Quand "claire.tremblay@courriel.ca" crée une randonnée sur "CCN-LUSK" le 2027-06-12T07:00 avec une capacité de 0
    Alors la création est refusée avec le motif "capacité invalide"
    Et aucune randonnée n'est créée

  Scénario: Échec si la certification est expirée à la date de la randonnée
    Quand "claire.tremblay@courriel.ca" crée une randonnée sur "CCN-PINK" le 2028-05-15T09:00 avec une capacité de 10
    Alors la création est refusée avec le motif "certification non valide à la date de la randonnée"
    Et aucune randonnée n'est créée

  Scénario: Échec si le niveau d'organisateur est inférieur à la difficulté du sentier
    Quand "claire.tremblay@courriel.ca" crée une randonnée sur "CCN-EARD" le 2027-07-17T07:00 avec une capacité de 8
    Alors la création est refusée avec le motif "niveau d'organisateur insuffisant"
    Et aucune randonnée n'est créée
