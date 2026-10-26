# language: fr
Fonctionnalité: closeHike
  Commande : closeHike(query: CloseHikeQuery)
  Le système ferme les inscriptions d'une randonnée lorsque la date limite est atteinte.
  Paramètres :
    - hikeId : identifiant de la randonnée

  Contexte:
    Étant donné la randonnée "H-2027-0012" sur le "Sentier de Luskville" le 2027-06-12T07:00 avec la date limite 2027-06-10T18:00 et le statut "complète"
    Et les inscriptions suivantes à "H-2027-0012" :
      | signUpId | randonneur                 | statut             |
      | S-0101   | julien.gagnon@courriel.ca  | confirmée          |
      | S-0103   | lucas.roy@courriel.ca      | en liste d'attente |
      | S-0105   | marc.ouellet@courriel.ca   | en liste d'attente |

  Scénario: Fermeture réussie à la date limite
    Étant donné nous sommes le 2027-06-10T18:00
    Quand le système ferme la randonnée "H-2027-0012"
    Alors la randonnée "H-2027-0012" a le statut "fermée"
    Et la transition vers "fermée" est enregistrée avec un horodatage et l'acteur "système"
    Et l'inscription S-0101 reste "confirmée"
    Et les inscriptions S-0103 et S-0105 ont le statut "annulée"
    Et "lucas.roy@courriel.ca" et "marc.ouellet@courriel.ca" reçoivent un courriel les avisant que la liste d'attente est fermée
    Et "julien.gagnon@courriel.ca" ne reçoit aucun courriel

  Scénario: Échec si la date limite n'est pas atteinte
    Étant donné nous sommes le 2027-06-09T12:00
    Quand le système ferme la randonnée "H-2027-0012"
    Alors la fermeture est refusée avec le motif "date limite non atteinte"
    Et la randonnée "H-2027-0012" a toujours le statut "complète"

  Scénario: Échec si la randonnée n'est ni ouverte ni complète
    Étant donné la randonnée "H-2027-0012" a le statut "annulée"
    Et nous sommes le 2027-06-10T18:00
    Quand le système ferme la randonnée "H-2027-0012"
    Alors la fermeture est refusée avec le motif "randonnée ni ouverte ni complète"
    Et la randonnée "H-2027-0012" a toujours le statut "annulée"
