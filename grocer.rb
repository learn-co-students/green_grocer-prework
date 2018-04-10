require 'pry'

raw_cart = [
{"AVOCADO" => {:price => 3.00, :clearance => true}},
{"AVOCADO" => {:price => 3.00, :clearance => true}},
{"TEMPEH" => {:price => 3.00, :clearance => true}}
]

def consolidate_cart(cart)
    new_cart_hash = {}
    cart.each do |cart_hash|
        counter = cart.count(cart_hash)
        cart_hash.each do |item, item_details_hash|
            new_cart_hash[item] = item_details_hash
            new_cart_hash[item][:count] = counter
        end
    end
    new_cart_hash
end

consolidate_cart(raw_cart)

Gcart = {
"AVOCADO" => {:price => 3.00, :clearance => true, :count => 3},
"KALE" => {:price => 3.00, :clearance => false, :count => 2},
"CHEESE" => {:price => 6.50, :clearance => false, :count => 3},
"BEER" => {:price => 13.00, :clearance => false, :count => 6}
}



coups = [
{:item => "AVOCADO", :num => 2, :cost => 5.00},
{:item => "BEER", :num => 2, :cost => 20.00},
{:item => "AVOCADO", :num => 2, :cost => 5.00},
{:item => "CHEESE", :num => 3, :cost => 15.00}
]

 def apply_coupons(cart, coupons)
    coupons.each do |coup_hashes|
        item_name = coup_hashes[:item]
        if cart.keys.include?(item_name) && cart[item_name][:count] >= coup_hashes[:num]
            if cart["#{item_name} W/COUPON"]
                cart["#{item_name} W/COUPON"][:count] += 1
            else
                cart["#{item_name} W/COUPON"] = {:price => coup_hashes[:cost], :clearance => cart[item_name][:clearance], :count => 1}
            end
            cart[item_name][:count] -= coup_hashes[:num]
        end
    end
    cart
 end

apply_coupons(Gcart, coups)

def apply_clearance(cart)
    cart.each do |item, item_details_hash|
        if item_details_hash[:clearance] == true
            discount = item_details_hash[:price] * 0.2
            item_details_hash[:price] -= discount
        end
    end
    cart
end

raw_cart = [
{"TEMPEH" => {:price => 3.00, :clearance => true}},
{"TEMPEH" => {:price => 3.00, :clearance => true}},
{"BEETS" => {:price => 2.50, :clearance => false,}},
]


def checkout(cart, coupons)
    new_cart = consolidate_cart(cart)
    coupon_cart = apply_coupons(new_cart, coupons)
    clearance_cart = apply_clearance(coupon_cart)
    sum = 0
    clearance_cart.each do |item, item_details_hash|
        sum += item_details_hash[:price] * item_details_hash[:count]
    end
    if sum > 100
        sum -= sum * 0.1
    end
    sum
    
end
    


checkout(raw_cart, coups)








