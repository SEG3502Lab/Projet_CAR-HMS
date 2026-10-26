# language: fr
Fonctionnalité: recordOrganizerCertification
  Commande : recordOrganizerCertification(query: RecordOrganizerCertificationQuery)
  Un administrateur enregistre la certification d'organisateur d'un randonneur,
  ce qui fait de lui un organisateur.
  Paramètres :
    - adminEmail : courriel de l'administrateur connecté
    - hikerEmail : courriel du randonneur certifié
    - certificateNumber : numéro unique du certificat
    - issueDate, expiryDate : dates de délivrance et d'expiration
    - organizerLevel : difficulté CCN maximale (facile, modéré, difficile, très difficile)

  Contexte:
    Étant donné l'administratrice "sophie.lavoie@car-hms.ca" est connectée
    Et le randonneur "lucas.roy@courriel.ca" existe sans certification
    Et le certificat "CERT-2027-0142" est déjà enregistré pour "claire.tremblay@courriel.ca"

  Scénario: Enregistrement réussi d'une certification
    Quand "sophie.lavoie@car-hms.ca" enregistre pour "lucas.roy@courriel.ca" la certification suivante :
      | certificateNumber | CERT-2027-0207 |
      | issueDate         | 2027-04-01     |
      | expiryDate        | 2029-03-31     |
      | organizerLevel    | très difficile |
    Alors "lucas.roy@courriel.ca" détient la certification "CERT-2027-0207" valide du 2027-04-01 au 2029-03-31
    Et le niveau d'organisateur de "lucas.roy@courriel.ca" est "très difficile"
    Et "lucas.roy@courriel.ca" est un organisateur

  Scénario: Échec si le demandeur n'est pas administrateur
    Étant donné "julien.gagnon@courriel.ca" est connecté
    Quand "julien.gagnon@courriel.ca" enregistre pour "lucas.roy@courriel.ca" la certification "CERT-2027-0207" du 2027-04-01 au 2029-03-31 de niveau "difficile"
    Alors l'enregistrement est refusé avec le motif "accès refusé"
    Et "lucas.roy@courriel.ca" n'est pas un organisateur

  Scénario: Échec si la date d'expiration n'est pas après la date de délivrance
    Quand "sophie.lavoie@car-hms.ca" enregistre pour "lucas.roy@courriel.ca" la certification "CERT-2027-0207" du 2027-04-01 au 2027-04-01 de niveau "difficile"
    Alors l'enregistrement est refusé avec le motif "dates de certification invalides"
    Et "lucas.roy@courriel.ca" n'est pas un organisateur

  Scénario: Échec si le numéro de certificat est déjà utilisé
    Quand "sophie.lavoie@car-hms.ca" enregistre pour "lucas.roy@courriel.ca" la certification "CERT-2027-0142" du 2027-04-01 au 2029-03-31 de niveau "difficile"
    Alors l'enregistrement est refusé avec le motif "numéro de certificat déjà utilisé"
    Et "lucas.roy@courriel.ca" n'est pas un organisateur
