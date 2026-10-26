# language: fr
Fonctionnalité: updateMembershipStatus
  Commande : updateMembershipStatus(query: UpdateMembershipStatusQuery)
  Un administrateur change le statut d'adhésion d'un randonneur.
  Paramètres :
    - adminEmail : courriel de l'administrateur connecté
    - hikerEmail : courriel du randonneur visé
    - newStatus : active, expired ou suspended (active, expirée ou suspendue)

  Contexte:
    Étant donné l'administratrice "sophie.lavoie@car-hms.ca" est connectée
    Et le randonneur "marc.ouellet@courriel.ca" existe avec l'adhésion "active"
    Et le randonneur "julien.gagnon@courriel.ca" existe avec l'adhésion "active"

  Scénario: Suspension réussie d'une adhésion
    Quand "sophie.lavoie@car-hms.ca" change l'adhésion de "marc.ouellet@courriel.ca" à "suspended"
    Alors l'adhésion de "marc.ouellet@courriel.ca" a le statut "suspendue"

  Scénario: Réactivation réussie d'une adhésion expirée
    Étant donné l'adhésion de "marc.ouellet@courriel.ca" a le statut "expirée"
    Quand "sophie.lavoie@car-hms.ca" change l'adhésion de "marc.ouellet@courriel.ca" à "active"
    Alors l'adhésion de "marc.ouellet@courriel.ca" a le statut "active"

  Scénario: Échec si le demandeur n'est pas administrateur
    Étant donné "julien.gagnon@courriel.ca" est connecté
    Quand "julien.gagnon@courriel.ca" change l'adhésion de "marc.ouellet@courriel.ca" à "suspended"
    Alors la modification est refusée avec le motif "accès refusé"
    Et l'adhésion de "marc.ouellet@courriel.ca" a toujours le statut "active"

  Scénario: Échec si le randonneur n'existe pas
    Quand "sophie.lavoie@car-hms.ca" change l'adhésion de "inconnu@courriel.ca" à "suspended"
    Alors la modification est refusée avec le motif "randonneur introuvable"

  Scénario: Échec si le statut est invalide
    Quand "sophie.lavoie@car-hms.ca" change l'adhésion de "marc.ouellet@courriel.ca" à "paused"
    Alors la modification est refusée avec le motif "statut d'adhésion invalide"
    Et l'adhésion de "marc.ouellet@courriel.ca" a toujours le statut "active"
