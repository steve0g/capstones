// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract GestionStockKorbanas {
    address public owner;
    
    // Le contrat doit pouvoir stocker plusieurs laptops, chacun avec : 
    // un modèle (texte), un prix (nombre), et s'il est disponible ou déjà vendu (vrai/faux)
    struct Laptop {
        string modele;
        uint256 prix;
        bool disponible;
    }

    Laptop[] public stock;

    constructor() {
        owner = msg.sender;
    }

    // Structure clé ➔ valeur : associe chaque modèle (string) au nombre total de laptops ajoutés (uint256)
    mapping(string => uint256) public historiqueModeles;    

    // N'importe qui doit pouvoir ajouter un nouveau laptop au stock, 
    // en donnant son modèle et son prix (il doit être marqué disponible automatiquement à l'ajout)
    function ajouterLaptop(string memory _modele, uint256 _prix) public {
        // on sécurise l'appel en autorisant seulement le propriétaire
        require(msg.sender == owner, "Seul le proprietaire peut ajouter un Laptop !");
        // On ajoute le laptop au tableau principal
        stock.push( Laptop(_modele, _prix, true) );

        // On incrémente le compteur historique pour ce modèle précis
        historiqueModeles[_modele] += 1;
    }

    // N'importe qui doit pouvoir consulter le prix d'un laptop précis, en donnant sa position dans le stock
    function consulterPrixLaptop(uint256 _index) public view returns(uint256 _prix) {
        return stock[_index].prix;
    }

    // N'importe qui doit pouvoir marquer un laptop comme vendu, en donnant sa position
    function marquerLaptopVendu(uint256 _index) public {
        // on sécurise l'appel en autorisant seulement le propriétaire
        require(msg.sender == owner, "Seul le owner peut marquer un Laptop comme vendu");
        stock[_index].disponible = false;
    }

    // N'importe qui doit pouvoir savoir combien de laptops sont encore disponibles au total, en une seule fois
    function nombreDeLaptopsDisponibles() public view returns(uint256) {
        uint256 compteur = 0; // on initialise le compteur à zéro
        for (uint256 i = 0; i < stock.length; i++) {
            if (stock[i].disponible == true) {
                compteur++;
            }
        }
        return compteur; // retourne la valeur que compteur a accumulée grâce aux incrémentations compteur++ qui ont eu lieu à l'intérieur de la boucle
    }

    // N'importe qui doit pouvoir vérifier si un modèle précis n'a jamais été en stock ou est actuellement épuisé
    function enRupture(string memory _modele) public view returns(bool) {
        // Condition "Jamais été en stock" : on vérifie notre historique clé -> valeur
        // Cette fonction renverra aussi true pour un modèle jamais ajouté au mapping,
        // car un mapping ne fait aucune différence entre "quantité = 0" et "clé jamais utilisée":
        // les deux situations renvoient la même valeur par défaut, 0.
        if (historiqueModeles[_modele] == 0) {
            return true;
        } else {
            return false;
        }
    }
}