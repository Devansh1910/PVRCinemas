import Foundation

func loadJSON() -> [FoodItem] {
    let json = """
    [
        {
            "ItemID": "S00005266",
            "ItemName": "SMALL COMBO SALTED",
            "IsVeg": true,
            "price": 200,
            "Isrepeat": false,
            "Isrecommended": true,
            "isPopularItem": false,
            "foodType": "2",
            "AddOnItem": [],
            "imageName": "small_combo_salted"
        },
        {
            "ItemID": "C00000057",
            "ItemName": "COMBO 1 (CheeseTub + 2 x Reg. Coke)",
            "IsVeg": true,
            "price": 460,
            "Isrepeat": true,
            "Isrecommended": false,
            "isPopularItem": true,
            "foodType": "1",
            "AddOnItem": [],
            "imageName": "combo_cheesetub_coke"
        },
        {
            "ItemID": "I00005351",
            "ItemName": "INS - SAMOSA (2PCS.)(1 Nos | 100.00 kcal)",
            "IsVeg": true,
            "price": 150,
            "Isrepeat": false,
            "Isrecommended": false,
            "isPopularItem": true,
            "foodType": "1",
            "AddOnItem": [
                {
                    "addonItemId": "E00005009",
                    "name": "EXTRA CHEESE DIP CUP",
                    "price": 20,
                    "quantity": 1,
                    "imageName": "cheese"

                }
            ],
            "imageName": "samosa"
        },
        {
            "ItemID": "B00007234",
            "ItemName": "CLASSIC BURGER",
            "IsVeg": false,
            "price": 300,
            "Isrepeat": true,
            "Isrecommended": false,
            "isPopularItem": false,
            "foodType": "1",
            "AddOnItem": [],
            "imageName": "classic_burger"
        },
        {
            "ItemID": "P00008234",
            "ItemName": "FAMILY-SIZED PIZZA",
            "IsVeg": false,
            "price": 700,
            "Isrepeat": false,
            "Isrecommended": true,
            "isPopularItem": false,
            "foodType": "2",
            "imageName": "family_pizza"
        },
        {
            "ItemID": "S00006214",
            "ItemName": "CHEESE POPCORN BUCKET",
            "IsVeg": true,
            "price": 250,
            "Isrepeat": false,
            "Isrecommended": true,
            "isPopularItem": false,
            "foodType": "2",
            "imageName": "cheese_popcorn"
        },
        {
            "ItemID": "T00001123",
            "ItemName": "VEG TACO TRIO",
            "IsVeg": true,
            "price": 350,
            "Isrepeat": false,
            "Isrecommended": true,
            "isPopularItem": false,
            "foodType": "1",
            "imageName": "veg_taco_trio"
        },
        {
            "ItemID": "C00002244",
            "ItemName": "COLD DRINK (LARGE)",
            "IsVeg": true,
            "price": 120,
            "Isrepeat": true,
            "Isrecommended": false,
            "isPopularItem": false,
            "foodType": "2",
            "imageName": "cold_drink_large"
        }
    ]
    """

    let data = Data(json.utf8)
    do {
        let items = try JSONDecoder().decode([FoodItem].self, from: data)
        return items
    } catch {
        print("Error decoding JSON: \(error)")
        return []
    }
}
