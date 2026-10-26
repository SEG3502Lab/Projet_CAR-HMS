# language: fr
Fonctionnalité: updateHikerInformation
  Commande : updateHikerInformation(query: UpdateHikerInformationQuery)
  Un randonneur connecté modifie les informations de son propre profil.
  Le courriel identifie le randonneur et n'est pas modifiable.
  Paramètres :
    - hikerEmail : courriel du randonneur dont le profil est modifié
    - firstName, lastName, phoneNumber : coordonnées
    - streetAddress, city, province, postalCode : adresse
    - emergencyContactName, emergencyContactPhone : contact d'urgence
    - skillLevel : débutant, intermédiaire, avancé ou expert

  Contexte:
    Étant donné le randonneur "julien.gagnon@courriel.ca" existe avec le téléphone "613-555-0123", l'adresse "12, rue Elgin, Ottawa, ON, K1P 5K8" et le niveau "intermédiaire"
    Et le randonneur "lucas.roy@courriel.ca" existe

  Scénario: Modification réussie de son propre profil
    Étant donné "julien.gagnon@courriel.ca" est connecté
    Quand "julien.gagnon@courriel.ca" modifie son profil avec :
      | firstName             | Julien                    |
      | lastName              | Gagnon                    |
      | phoneNumber           | 819-555-0199              |
      | streetAddress         | 210, boulevard de Lucerne |
      | city                  | Gatineau                  |
      | province              | QC                        |
      | postalCode            | J9H 7J3                   |
      | emergencyContactName  | Chloé Gagnon              |
      | emergencyContactPhone | 819-555-0160              |
      | skillLevel            | avancé                    |
    Alors le profil de "julien.gagnon@courriel.ca" a le téléphone "819-555-0199"
    Et le profil de "julien.gagnon@courriel.ca" a l'adresse "210, boulevard de Lucerne, Gatineau, QC, J9H 7J3"
    Et le profil de "julien.gagnon@courriel.ca" a le contact d'urgence "Chloé Gagnon" au "819-555-0160"
    Et le profil de "julien.gagnon@courriel.ca" a le niveau "avancé"
    Et le courriel du randonneur est toujours "julien.gagnon@courriel.ca"

  Scénario: Échec si le randonneur modifie le profil d'un autre randonneur
    Étant donné "lucas.roy@courriel.ca" est connecté
    Quand "lucas.roy@courriel.ca" modifie le profil de "julien.gagnon@courriel.ca" avec le téléphone "819-555-0000"
    Alors la modification est refusée avec le motif "accès refusé"
    Et le profil de "julien.gagnon@courriel.ca" a toujours le téléphone "613-555-0123"

  Scénario: Échec si le randonneur n'est pas connecté
    Quand un visiteur non connecté modifie le profil de "julien.gagnon@courriel.ca" avec le téléphone "819-555-0000"
    Alors la modification est refusée avec le motif "connexion requise"
    Et le profil de "julien.gagnon@courriel.ca" a toujours le téléphone "613-555-0123"
