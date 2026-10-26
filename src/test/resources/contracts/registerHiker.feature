# language: fr
Fonctionnalité: registerHiker
  Commande : registerHiker(query: RegisterHikerQuery): String
  Une personne invitée crée son compte de randonneur à l'aide d'un code d'invitation.
  Paramètres :
    - invitationCode : code d'invitation reçu
    - email, password : identifiants du compte
    - firstName, lastName, phoneNumber : coordonnées
    - streetAddress, city, province, postalCode : adresse
    - dateOfBirth : date de naissance
    - emergencyContactName, emergencyContactPhone : contact d'urgence
    - skillLevel : débutant, intermédiaire, avancé ou expert
    - waiverAccepted : acceptation de la décharge de responsabilité
    - guardianName : nom du tuteur légal (obligatoire si moins de 18 ans)
  Retour : l'identifiant du randonneur créé.

  Contexte:
    Étant donné le code d'invitation "INV-7K2P-9QX4" existe et n'est pas utilisé
    Et le code d'invitation "INV-3MZ8-1RT6" existe et est déjà utilisé
    Et un randonneur avec le courriel "julien.gagnon@courriel.ca" existe déjà
    Et nous sommes le 2027-04-15T10:00

  Scénario: Inscription réussie d'un randonneur adulte
    Quand une personne s'inscrit avec les informations suivantes :
      | invitationCode        | INV-7K2P-9QX4               |
      | email                 | emilie.bouchard@courriel.ca |
      | password              | Sentier!2027                |
      | firstName             | Émilie                      |
      | lastName              | Bouchard                    |
      | phoneNumber           | 819-555-0147                |
      | streetAddress         | 45, rue Laurier             |
      | city                  | Gatineau                    |
      | province              | QC                          |
      | postalCode            | J8X 3V7                     |
      | dateOfBirth           | 1994-08-21                  |
      | emergencyContactName  | Paul Bouchard               |
      | emergencyContactPhone | 819-555-0182                |
      | skillLevel            | intermédiaire               |
      | waiverAccepted        | true                        |
      | guardianName          |                             |
    Alors un identifiant de randonneur est retourné
    Et le randonneur "emilie.bouchard@courriel.ca" existe avec le niveau "intermédiaire"
    Et son adhésion a le statut "active"
    Et le code d'invitation "INV-7K2P-9QX4" est marqué comme utilisé

  Scénario: Inscription réussie d'un randonneur mineur avec tuteur légal
    Quand une personne née le 2011-03-02 s'inscrit avec le code "INV-7K2P-9QX4", le courriel "leo.bouchard@courriel.ca", la décharge acceptée et le tuteur légal "Émilie Bouchard"
    Alors un identifiant de randonneur est retourné
    Et le randonneur "leo.bouchard@courriel.ca" existe avec le tuteur légal "Émilie Bouchard"
    Et son adhésion a le statut "active"
    Et le code d'invitation "INV-7K2P-9QX4" est marqué comme utilisé

  Scénario: Échec si le code d'invitation n'existe pas
    Quand une personne s'inscrit avec le code "INV-0000-0000" et le courriel "emilie.bouchard@courriel.ca"
    Alors l'inscription est refusée avec le motif "code d'invitation invalide"
    Et aucun randonneur "emilie.bouchard@courriel.ca" n'existe

  Scénario: Échec si le code d'invitation est déjà utilisé
    Quand une personne s'inscrit avec le code "INV-3MZ8-1RT6" et le courriel "emilie.bouchard@courriel.ca"
    Alors l'inscription est refusée avec le motif "code d'invitation déjà utilisé"
    Et aucun randonneur "emilie.bouchard@courriel.ca" n'existe

  Scénario: Échec si le courriel est déjà utilisé
    Quand une personne s'inscrit avec le code "INV-7K2P-9QX4" et le courriel "julien.gagnon@courriel.ca"
    Alors l'inscription est refusée avec le motif "courriel déjà utilisé"
    Et le code d'invitation "INV-7K2P-9QX4" n'est pas utilisé

  Scénario: Échec si la décharge n'est pas acceptée
    Quand une personne s'inscrit avec le code "INV-7K2P-9QX4", le courriel "emilie.bouchard@courriel.ca" et la décharge refusée
    Alors l'inscription est refusée avec le motif "décharge non acceptée"
    Et aucun randonneur "emilie.bouchard@courriel.ca" n'existe
    Et le code d'invitation "INV-7K2P-9QX4" n'est pas utilisé

  Scénario: Échec si un mineur n'indique pas de tuteur légal
    Quand une personne née le 2011-03-02 s'inscrit avec le code "INV-7K2P-9QX4", le courriel "leo.bouchard@courriel.ca", la décharge acceptée et sans tuteur légal
    Alors l'inscription est refusée avec le motif "tuteur légal obligatoire"
    Et aucun randonneur "leo.bouchard@courriel.ca" n'existe
    Et le code d'invitation "INV-7K2P-9QX4" n'est pas utilisé
