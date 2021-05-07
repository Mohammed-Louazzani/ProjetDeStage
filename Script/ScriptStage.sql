
create database Ofppt
go
use Ofppt
go

create table NiveauFiliere(
idNiveauFiliere int constraint pk_NiveauFiliere primary key,
NomNiveauFiliere varchar(50),
Description varchar(200),
);

go

create table Filiere(
idFiliere int constraint pk_Filiere primary key,
NomFiliere varchar(50),
idNiveauFiliere int constraint fk_Filiere_NivFiliere foreign key references NiveauFiliere(idNiveauFiliere)
);

go

create table NiveauClasse(
idNiveauClasse int constraint pk_NiveauClasse primary key,
NomNiveauClasse varchar(50),
);

go

create table ClasseGroupe(
idClasse int constraint pk_ClasseGroupe primary key,
NomClasse varchar(50),
idNiveauClasse int constraint fk_ClasseGroupe_NivClasse foreign key references NiveauClasse(idNiveauClasse),
idFiliere int constraint fk_ClasseGroupe_Filiere foreign key references Filiere(idFiliere),
idClassePere int constraint fk_ClasseGroupe_Pere foreign key references ClasseGroupe(idClasse),
);

go

create table EFF(
idEFF int constraint pk_EFF primary key,
Date date,
HeureDebut time,
HeureFin time,
Pratique bit,
Theorique bit,
Synthese bit
);

go

create table ClasseExam(
idClasseExam int constraint pk_ClasseExam primary key,
NomClasseExam varchar(50),
idEFF int constraint fk_ClasseExam_EFF foreign key references EFF(idEFF),
);

go

create table Stagiaire(
CEF int constraint pk_Stagiaire primary key,
idClasse int constraint fk_Stagiaire_ClasseGroupe foreign key references ClasseGroupe(idClasse),
idClasseExam int constraint fk_Stagiaire_ClasseExam foreign key references ClasseExam(idClasseExam),
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
MoyenneBac float,
EnFormation bit
);

go

create table TypeAbsence(
idTypeAbs int constraint pk_TypeAbsence primary key,
NomTypeAbs varchar(50),
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

create table Module(
idModule int constraint pk_Module primary key,
NomModule varchar(200),
MasseHoraire int
);

go

create table Absence(
idAbs int constraint pk_Absence primary key,
idTypeAbs int constraint fk_Absence_TypeAbsence foreign key references TypeAbsence(idTypeAbs) ,
Matricule varchar(20)constraint fk_Absence_Formateur foreign key references Formateur(Matricule),
CEF int constraint fk_Absence_Stagiaire foreign key references Stagiaire(CEF),
idModule int constraint fk_Absence_Module foreign key references Module(idModule),
RemarqueAbs varchar(300),
DateSeance date,
HeureDebut time,
HeureFin time
);

go

create table EFM(
idEFM int constraint pk_EFM primary key,
Date date,
HeureDebut time,
HeureFin time,
Pratique bit,
Theorique bit,
Synthese bit,
idModule int constraint fk_EFM_Module foreign key references Module(idModule),
); 

go

create table AbsenceExam(
idAbsExam int constraint pk_AbsenceExam primary key,
CEF int constraint fk_AbsenceExam_Stagiaire foreign key references Stagiaire(CEF),
idEFM int constraint fk_AbsenceExam_EFM foreign key references EFM(idEFM),
RemarqueAbs varchar(300),
DateSeance date,
HeureDebut time,
HeureFin time
);

go


create table Affecter(
idClasse int constraint fk_Affecter_ClasseGroupe foreign key references ClasseGroupe(idClasse),
Matricule varchar(20)constraint fk_Affecter_Formateur foreign key references Formateur(Matricule),
idModule int constraint fk_Affecter_Module foreign key references Module(idModule),
constraint pk_Affecter primary key (idClasse,Matricule,idModule)
);

go

create table Salle(
idSalle int constraint pk_Salle primary key,
NomSalle varchar(50),
NbChaise int,
idEFF int constraint fk_Salle_EFF foreign key references EFF(idEFF),
);

go

create table Passer(
idPasser int constraint pk_Passer primary key ,
idClasse int constraint fk_Passer_ClasseGroupe foreign key references ClasseGroupe(idClasse),
idEFM int constraint fk_Passer_EFM foreign key references EFM(idEFM),
idSalle int  constraint fk_Passer_Salle foreign key references Salle(idSalle),
constraint uniquePassé unique (idClasse,idEFM,idSalle)
);

go

create table Etudier(
idNiveauClasse int constraint fk_Etudier_NivClasse foreign key references NiveauClasse(idNiveauClasse),
idModule int constraint fk_Etudier_Module foreign key references Module(idModule),
idNiveauFiliere int constraint fk_Etudier_NivFiliere foreign key references NiveauFiliere(idNiveauFiliere),
constraint pk_Etudier primary key (idNiveauClasse,idModule,idNiveauFiliere)
);

go

create table Surveiller(
Matricule varchar(20) constraint fk_Surveiller_Formateur foreign key references Formateur(Matricule),
idSalle int constraint fk_Surveiller_Salle foreign key references Salle(idSalle),
DateExam date,
HeureDebutExam time,
HeureFinExam time,
constraint pk_Surveiller primary key (Matricule,idSalle,HeureDebutExam,HeureFinExam,DateExam)
);

go

create table Utilisateur(
login varchar(50) constraint pk_Utilisateur primary key,
password varchar(50),
Nom varchar(50),
Prenom varchar(50),
Email varchar(50),
typeUtilisateur varchar(50),
Validation bit,
Hash varchar(200),
);