# language: fr
Fonctionnalité: cancelHike
  Commande : cancelHike(query: CancelHikeQuery)
  L'organisateur d'une randonnée, ou un administrateur, annule une randonnée.
  Paramètres :
    - hikeId : identifiant de la randonnée
    - requesterEmail : courriel de la personne qui demande l'annulation
    - reason : motif de l'annulation (obligatoire)

  Contexte:
    Étant donné la randonnée "H-2027-0012" sur le "Sentier de Luskville" le 2027-06-12T07:00, organisée par "claire.tremblay@courriel.ca", avec le statut "complète"
    Et les inscriptions suivantes à "H-2027-0012" :
      | signUpId | randonneur                 | statut                |
      | S-0101   | julien.gagnon@courriel.ca  | confirmée             |
      | S-0102   | amira.haddad@courriel.ca   | confirmée             |
      | S-0103   | lucas.roy@courriel.ca      | en liste d'attente    |
      | S-0104   | nadia.morin@courriel.ca    | annulée               |
    Et l'administratrice "sophie.lavoie@car-hms.ca" existe
    Et nous sommes le 2027-06-08T10:00

  Scénario: Annulation réussie par l'organisatrice
    Quand "claire.tremblay@courriel.ca" annule "H-2027-0012" avec le motif "Avertissement d'orages violents"
    Alors la randonnée "H-2027-0012" a le statut "annulée"
    Et la transition vers "annulée" est enregistrée avec un horodatage et l'acteur "claire.tremblay@courriel.ca"
    Et les inscriptions S-0101, S-0102 et S-0103 ont le statut "annulée"
    Et l'inscription S-0104 reste "annulée"
    Et "julien.gagnon@courriel.ca", "amira.haddad@courriel.ca" et "lucas.roy@courriel.ca" reçoivent un courriel d'annulation contenant le motif "Avertissement d'orages violents"
    Et "nadia.morin@courriel.ca" ne reçoit aucun courriel

  Scénario: Annulation réussie par un administrateur
    Quand "sophie.lavoie@car-hms.ca" annule "H-2027-0012" avec le motif "Sentier fermé par la CCN"
    Alors la randonnée "H-2027-0012" a le statut "annulée"
    Et la transition vers "annulée" est enregistrée avec un horodatage et l'acteur "sophie.lavoie@car-hms.ca"
    Et toutes les inscriptions actives de "H-2027-0012" ont le statut "annulée"

  Scénario: Échec si le demandeur n'est ni l'organisateur ni un administrateur
    Quand "julien.gagnon@courriel.ca" annule "H-2027-0012" avec le motif "Je ne peux plus venir"
    Alors l'annulation est refusée avec le motif "accès refusé"
    Et la randonnée "H-2027-0012" a toujours le statut "complète"

  Scénario: Échec si la randonnée est déjà annulée
    Étant donné la randonnée "H-2027-0012" a le statut "annulée"
    Quand "claire.tremblay@courriel.ca" annule "H-2027-0012" avec le motif "Doublon"
    Alors l'annulation est refusée avec le motif "randonnée déjà annulée"

  Scénario: Échec si la randonnée est terminée
    Étant donné la randonnée "H-2027-0012" a le statut "terminée"
    Quand "claire.tremblay@courriel.ca" annule "H-2027-0012" avec le motif "Erreur"
    Alors l'annulation est refusée avec le motif "randonnée terminée"

  Scénario: Échec si la randonnée est déjà commencée
    Étant donné nous sommes le 2027-06-12T08:30
    Quand "claire.tremblay@courriel.ca" annule "H-2027-0012" avec le motif "Pluie"
    Alors l'annulation est refusée avec le motif "randonnée déjà commencée"
    Et la randonnée "H-2027-0012" a toujours le statut "complète"

  Scénario: Échec si le motif est absent
    Quand "claire.tremblay@courriel.ca" annule "H-2027-0012" avec le motif ""
    Alors l'annulation est refusée avec le motif "motif obligatoire"
    Et la randonnée "H-2027-0012" a toujours le statut "complète"
