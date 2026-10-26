# language: fr
Fonctionnalité: cancelSignUp
  Commande : cancelSignUp(query: CancelSignUpQuery)
  Un randonneur annule sa propre inscription avant la date limite. Une place
  confirmée libérée revient au premier randonneur de la liste d'attente.
  Paramètres :
    - signUpId : identifiant de l'inscription
    - hikerEmail : courriel du randonneur connecté

  Contexte:
    Étant donné la randonnée "H-2027-0012" sur le "Sentier de Luskville" le 2027-06-12T07:00 avec la date limite 2027-06-10T18:00, de capacité 12
    Et nous sommes le 2027-06-05T09:00

  Scénario: Annulation d'une inscription confirmée avec liste d'attente
    Étant donné la randonnée "H-2027-0012" a le statut "complète"
    Et les inscriptions suivantes à "H-2027-0012" :
      | signUpId | randonneur                 | statut             | inscrit le        |
      | S-0101   | julien.gagnon@courriel.ca  | confirmée          | 2027-05-20T10:00  |
      | S-0103   | lucas.roy@courriel.ca      | en liste d'attente | 2027-05-28T14:12  |
      | S-0105   | marc.ouellet@courriel.ca   | en liste d'attente | 2027-05-30T08:45  |
    Quand "julien.gagnon@courriel.ca" annule l'inscription "S-0101"
    Alors l'inscription S-0101 a le statut "annulée"
    Et l'inscription S-0103 a le statut "confirmée"
    Et "lucas.roy@courriel.ca" reçoit un courriel de confirmation
    Et l'inscription S-0105 est en liste d'attente à la position 1
    Et la randonnée "H-2027-0012" a toujours le statut "complète"
    Et le nombre de places restantes de "H-2027-0012" est 0

  Scénario: Annulation d'une inscription confirmée sans liste d'attente
    Étant donné la randonnée "H-2027-0012" a le statut "complète"
    Et "julien.gagnon@courriel.ca" a l'inscription "S-0101" au statut "confirmée"
    Et la liste d'attente de "H-2027-0012" est vide
    Quand "julien.gagnon@courriel.ca" annule l'inscription "S-0101"
    Alors l'inscription S-0101 a le statut "annulée"
    Et le nombre de places restantes de "H-2027-0012" est 1
    Et la randonnée "H-2027-0012" a le statut "ouverte"
    Et la transition vers "ouverte" est enregistrée avec un horodatage et l'acteur "julien.gagnon@courriel.ca"

  Scénario: Annulation d'une inscription en liste d'attente
    Étant donné la randonnée "H-2027-0012" a le statut "complète"
    Et "lucas.roy@courriel.ca" a l'inscription "S-0103" en liste d'attente à la position 1
    Et "marc.ouellet@courriel.ca" a l'inscription "S-0105" en liste d'attente à la position 2
    Quand "lucas.roy@courriel.ca" annule l'inscription "S-0103"
    Alors l'inscription S-0103 a le statut "annulée"
    Et l'inscription S-0105 est en liste d'attente à la position 1
    Et le nombre de places restantes de "H-2027-0012" est 0

  Scénario: Échec si l'inscription appartient à un autre randonneur
    Étant donné "julien.gagnon@courriel.ca" a l'inscription "S-0101" au statut "confirmée"
    Quand "lucas.roy@courriel.ca" annule l'inscription "S-0101"
    Alors l'annulation est refusée avec le motif "accès refusé"
    Et l'inscription S-0101 a toujours le statut "confirmée"

  Scénario: Échec si l'inscription est déjà annulée
    Étant donné "julien.gagnon@courriel.ca" a l'inscription "S-0101" au statut "annulée"
    Quand "julien.gagnon@courriel.ca" annule l'inscription "S-0101"
    Alors l'annulation est refusée avec le motif "inscription non active"

  Scénario: Échec après la date limite d'inscription
    Étant donné "julien.gagnon@courriel.ca" a l'inscription "S-0101" au statut "confirmée"
    Et nous sommes le 2027-06-11T08:00
    Quand "julien.gagnon@courriel.ca" annule l'inscription "S-0101"
    Alors l'annulation est refusée avec le motif "date limite dépassée"
    Et l'inscription S-0101 a toujours le statut "confirmée"
