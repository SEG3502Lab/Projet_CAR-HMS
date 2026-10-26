# language: fr
Fonctionnalité: sendHikeReminder
  Commande : sendHikeReminder(query: SendHikeReminderQuery)
  Le système envoie un rappel par courriel aux participants confirmés 24 heures
  avant le départ, avec un avertissement si de la pluie ou de la neige est prévue.
  Paramètres :
    - hikeId : identifiant de la randonnée

  Contexte:
    Étant donné la randonnée "H-2027-0031" sur le "Sentier du Lac-Pink" le 2027-09-18T09:00, point de départ "stationnement P11, chemin du Lac-Pink", avec le statut "fermée"
    Et les inscriptions suivantes à "H-2027-0031" :
      | signUpId | randonneur                 | statut    |
      | S-0310   | julien.gagnon@courriel.ca  | confirmée |
      | S-0311   | amira.haddad@courriel.ca   | confirmée |
      | S-0312   | lucas.roy@courriel.ca      | annulée   |
    Et aucun rappel n'a été envoyé pour "H-2027-0031"
    Et nous sommes le 2027-09-17T09:00

  Scénario: Envoi réussi du rappel par beau temps
    Étant donné la météo prévue pour le 2027-09-18 au Lac-Pink est "ensoleillé"
    Quand le système envoie le rappel de "H-2027-0031"
    Alors "julien.gagnon@courriel.ca" et "amira.haddad@courriel.ca" reçoivent un rappel indiquant la date "2027-09-18", l'heure "09:00", le sentier "Sentier du Lac-Pink" et le point de départ "stationnement P11, chemin du Lac-Pink"
    Et le rappel ne contient aucun avertissement météo
    Et "lucas.roy@courriel.ca" ne reçoit aucun rappel
    Et le rappel de "H-2027-0031" est marqué comme envoyé

  Scénario: Rappel avec avertissement lorsque de la pluie est prévue
    Étant donné la météo prévue pour le 2027-09-18 au Lac-Pink est "pluie"
    Quand le système envoie le rappel de "H-2027-0031"
    Alors "julien.gagnon@courriel.ca" et "amira.haddad@courriel.ca" reçoivent un rappel contenant un avertissement de pluie
    Et le rappel de "H-2027-0031" est marqué comme envoyé

  Scénario: Rappel avec avertissement lorsque de la neige est prévue
    Étant donné la météo prévue pour le 2027-09-18 au Lac-Pink est "neige"
    Quand le système envoie le rappel de "H-2027-0031"
    Alors "julien.gagnon@courriel.ca" et "amira.haddad@courriel.ca" reçoivent un rappel contenant un avertissement de neige
    Et le rappel de "H-2027-0031" est marqué comme envoyé

  Scénario: Rappel sans avertissement lorsque la météo est indisponible
    Étant donné le service météo est indisponible
    Quand le système envoie le rappel de "H-2027-0031"
    Alors "julien.gagnon@courriel.ca" et "amira.haddad@courriel.ca" reçoivent un rappel sans avertissement météo
    Et le rappel de "H-2027-0031" est marqué comme envoyé

  Scénario: Échec si la randonnée est annulée
    Étant donné la randonnée "H-2027-0031" a le statut "annulée"
    Quand le système envoie le rappel de "H-2027-0031"
    Alors l'envoi est refusé avec le motif "randonnée annulée"
    Et aucun rappel n'est envoyé

  Scénario: Échec si le départ n'est pas dans 24 heures
    Étant donné nous sommes le 2027-09-15T09:00
    Quand le système envoie le rappel de "H-2027-0031"
    Alors l'envoi est refusé avec le motif "départ pas dans 24 heures"
    Et aucun rappel n'est envoyé

  Scénario: Échec si un rappel a déjà été envoyé
    Étant donné un rappel a déjà été envoyé pour "H-2027-0031"
    Quand le système envoie le rappel de "H-2027-0031"
    Alors l'envoi est refusé avec le motif "rappel déjà envoyé"
    Et aucun nouveau rappel n'est envoyé
