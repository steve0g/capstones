// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import {Proprietaire} from "./Proprietaire.sol";

contract Boutique is Proprietaire {
    
    // Une boutique a un nom, lisible par tous.
    string public nomBoutique;

    // Elle contient des produits (nom, prix, quantité), consultables par tous.
    struct Produit {
        string nom;
        uint256 prix;
        uint256 quantite;
    }
    
    // Elle garde, pour chaque nom de produit, le total vendu depuis la création.
    // Associe le NOM d'un produit (clé) à son CUMUL HISTORIQUE vendu (valeur)
    // Si le produit n'est pas encore inscrit, sa valeur de départ est automatiquement 0
    mapping(string => uint256) public totalVendu;

    // Le propriétaire et le nom sont fournis à la création. La boutique ne les devine pas.
    constructor(address _proprietaire, string memory _nomBoutique) {
        proprietaire = _proprietaire;
        nomBoutique = _nomBoutique;
    }

    // tableau dynamique pour stocker les produits / L'Étagère : Contient toutes les boîtes produits, accessibles par numéro (index)
    Produit[] public listeDesProduits;

    // ajouter un produit (propriétaire uniquement)
    function ajouterProduit(string memory _nom, uint256 _prix, uint256 _quantite) public {

        // verification du proprietaire
        verification();

        // ajout du produit dans le tableau 
        listeDesProduits.push(Produit(_nom, _prix, _quantite));
    }

    // vendre une quantité d’un produit (propriétaire uniquement).
    // la vente est refusée si le stock est insuffisant, elle diminue la quantité et alimente le total vendu.
    function vendreQuantiteProduit(uint256 _index, uint256 _quantite) public {
        verification();

        // Récupérer le produit dans le tableau via son index
        // On vise directement la vraie boîte sur l'étagère à l'index demandé.
        // Les modifications sur 'produit' impacteront directement la blockchain donc on utilise storage
        Produit storage produit = listeDesProduits[_index];

        // Refuser la vente si le stock est insuffisant
        require(produit.quantite >= _quantite, "Vente refusee: Stock insuffisant");

        // Diminuer la quantité de ce produit
        // On retire la quantité vendue de la boîte visée
        produit.quantite -= _quantite;

        // Alimenter le total vendu en récupérant le nom du produit
        // Regarder le tableau noir : totalVendu[...]
        // Prendre le nom écrit sur la boîte visée par le laser : [produit.nom]
        // Ajouter la quantité vendue : += _quantite;
        totalVendu[produit.nom] += _quantite;
    }

    // fonction pour obtenir la valeur du stock
    function obtenirValeurStock() public view returns(uint256) {
        
        // initialiser une variable pour le total du stock
        uint256 totalStock = 0;

        // boucle
        for (uint256 i = 0; i < listeDesProduits.length; i++) {

            // à chaque tour, on ajoute la valeur du produit (prix × quantité) au total déjà calculé
            totalStock += listeDesProduits[i].prix * listeDesProduits[i].quantite;
            // ou totalStock = totalStock + (listeDesProduits[i].prix * listeDesProduits[i].quantite);
        }
        return totalStock;
    }

    // fonction pour connaitre le nombre de produit
    function nombreDeProduits() public view returns(uint256) {
        return listeDesProduits.length;
    }
}