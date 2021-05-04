create database Ofppt
go
use Ofppt
go

create table Stagiaire(
CEF int constraint pk_Stagiaire primary key,
NomStagiaire varchar(50),
PrenomStagiaire varchar(50),
NomArabe varchar(50),
PrenomArabe varchar(50),
CodeMassar varchar(20),
CIN varchar(10),
Genre varchar(20),
DateNaissance Date,
Adresse varchar(200),
NumTel varchar(20),
Email varchar(100),
Nationalité varchar(20),
NiveauScolaire varchar(50),
DatePv Date,
CommentaireFS varchar(200),
AnnéeBac int,
MoyenneBac float
);

go 

create table NiveauClasse(
idNiveauClasse int constraint pk_NiveauClasse primary key,
NomNiveauClasse varchar(50),
);

go

create table NiveauFiliere(
idNiveauFiliere int constraint pk_NiveauFiliere primary key,
NomNiveauFiliere varchar(50),
Description varchar(200),
);


create table Filiere(
idFiliere int constraint pk_Filiere primary key,
NomFiliere varchar(50),
idNiveauFiliere int constraint fk_Filiere_NivFiliere foreign key references NiveauFiliere(idNiveauFiliere)
);

go

create table PassageEFF(
idPS_EFF int constraint pk_PassageEFF primary key,
Date date,
HeureDebut time,
HeureFin time,
Pratique bit,
Theorique bit,
Synthese bit
);

go

create table ClasseGroupe(
idClasse int constraint pk_ClasseGroupe primary key,
NomClasse varchar(50),
idNiveauClasse int constraint fk_ClasseGroupe_NivClasse foreign key references NiveauClasse(idNiveauClasse),
idFiliere int constraint fk_ClasseGroupe_Filiere foreign key references Filiere(idFiliere),
idPS_EFF int constraint fk_ClasseGroupe_PassageEFF foreign key references PassageEFF(idPS_EFF),
idClassePere int constraint fk_ClasseGroupe_Pere foreign key references ClasseGroupe(idClasse),
);

go

create table Inscription(
CEF int constraint fk_Inscription_Stagiaire foreign key references Stagiaire(CEF),
idClasse int constraint fk_Inscription_ClasseGroupe foreign key references ClasseGroupe(idClasse),
dateInscription date,
dateDossierComplet date,
constraint pk_Inscription primary key (CEF,idClasse)
);

go

create table Module(
idModule int constraint pk_Module primary key,
NomModule varchar(200),
MasseHoraire int
);

go

create table Etudier(
idNiveauClasse int constraint fk_Etudier_NivClasse foreign key references NiveauClasse(idNiveauClasse),
idModule int constraint fk_Etudier_Module foreign key references Module(idModule),
idNiveauFiliere int constraint fk_Etudier_NivFiliere foreign key references NiveauFiliere(idNiveauFiliere),
constraint pk_Etudier primary key (idNiveauClasse,idModule,idNiveauFiliere)
);

go

create table Salle(
idSalle int constraint pk_Salle primary key,
NomSalle varchar(50),
NbChaise int,
idPS_EFF int constraint fk_Salle_PassageEFF foreign key references PassageEFF(idPS_EFF),
);

go

create table EFM_CC(
idEFM_CC int constraint pk_EFM_CC primary key,
Date date,
HeureDebut time,
HeureFin time,
Pratique bit,
Theorique bit,
Synthese bit,
idModule int constraint fk_EFM_CC_Module foreign key references Module(idModule),
); 

go

create table Passé(
idPassé int constraint pk_Passé primary key ,
idClasse int constraint fk_Passé_ClasseGroupe foreign key references ClasseGroupe(idClasse),
idEFM_CC int constraint fk_Passé_EFM_CC foreign key references EFM_CC(idEFM_CC),
idSalle int  constraint fk_Passé_Salle foreign key references Salle(idSalle),
constraint uniquePassé unique (idClasse,idEFM_CC,idSalle)
);

go

create table Formateur(
Matricule varchar(20) constraint pk_Formateur primary key ,
NomFormateur varchar(50),
PrenomFormateur varchar(50),
Email varchar(100),
Tel varchar(20),
typeFormateur varchar(50),
);

go

create table Surveiller(
Matricule varchar(20) constraint fk_Surveiller_Formateur foreign key references Formateur(Matricule),
idSalle int constraint fk_Surveiller_Salle foreign key references Salle(idSalle),
HeureDebutExam time,
HeureFinExam time,
DateExam date,
constraint pk_Surveiller primary key (Matricule,idSalle)
);

go

create table TypeAbsence(
idTypeAbs int constraint pk_TypeAbsence primary key,
NomTypeAbs varchar(50),
);

go

create table Absence(
idAbs int constraint pk_Absence primary key,
idTypeAbs int constraint fk_Absence_TypeAbsence foreign key references TypeAbsence(idTypeAbs) ,
Matricule varchar(20)constraint fk_Absence_Formateur foreign key references Formateur(Matricule),
CEF int constraint fk_Absence_Stagiaire foreign key references Stagiaire(CEF),
idModule int constraint fk_Absence_Module foreign key references Module(idModule),
RemarqueAbs varchar(300),
Seance varchar(50),
DateSeance date,
HeureDebut time,
HeureFin time
);