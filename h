
[1mFrom:[0m /home/OGonzalezNYC/green_grocer-prework/grocer.rb @ line 24 Object#consolidate_cart:

     [1;34m3[0m: [32mdef[0m [1;34mconsolidate_cart[0m(cart)
     [1;34m4[0m:   cart_hash = {}
     [1;34m5[0m:   cart.each [32mdo[0m |food_item_hash|
     [1;34m6[0m:     food_item_frequency = cart.count(food_item_hash)
     [1;34m7[0m:     food_item_hash.each [32mdo[0m |food_item_key, attribute_hash|
     [1;34m8[0m:       attribute_hash[[33m:count[0m] = food_item_frequency
     [1;34m9[0m: 
    [1;34m10[0m: [1;34m# attribute_hash.each do |attribute_symbol, attribute_value|[0m
    [1;34m11[0m:         [32mif[0m cart_hash = {}
    [1;34m12[0m:           cart_hash = {food_item_key => attribute_hash}
    [1;34m13[0m:         [32melse[0m  cart_hash[food_item_key] = attribute_hash
    [1;34m14[0m:         [32mend[0m 
    [1;34m15[0m: [1;34m#  binding.pry #  After 3 exits:   [0m
    [1;34m16[0m:               [1;34m#  food_item_key   properly returns    "AVOCADO"  ;  [0m
    [1;34m17[0m:               [1;34m#   attribute_hash properly returns  {:price=>3.0, :clearance=>true, :count=>2}[0m
    [1;34m18[0m:               [1;34m#  {food_item_key => attribute_hash} properly returns  {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>2}}  ;    [0m
    [1;34m19[0m:               [1;34m#    cart_hash[food_item_key]   properly returns   {:price=>3.0, :clearance=>true, :count=>2}    ;   and  [0m
    [1;34m20[0m:               [1;34m# cart_hash properly returns {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>2} .[0m
    [1;34m21[0m: [1;34m#       cart_hash = cart_hash.uniq[0m
    [1;34m22[0m: [1;34m#     cart_hash = {food_item_key => {attribute_symbol => attribute_value, attribute_symbol => attribute_value, :count => food_item_frequency}}[0m
    [1;34m23[0m:     [32mend[0m 
 => [1;34m24[0m:   binding.pry 
    [1;34m25[0m:   [32mend[0m 
    [1;34m26[0m:   cart_hash
    [1;34m27[0m: [32mend[0m

