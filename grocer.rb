require 'pry'

def consolidate_cart(cart)
  # code here
  consolidated_hash = {}
  cart.each do |cart_item|
    if consolidated_hash[cart_item.keys[0]] == nil
      items_to_consolidate = cart.select{|element| element == cart_item}
      consolidated_hash[cart_item.keys[0]] = cart_item[cart_item.keys[0]]
      consolidated_hash[cart_item.keys[0]][:count] = items_to_consolidate.size
    end
  end
  consolidated_hash
end

 cart2 = {
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
}
coupon2 = {:item => "AVOCADO", :num => 2, :cost => 5.0}
def apply_coupons(cart, coupons)
  # code here
  couponed_cart = {}
  cart.each do |cart_item|
    if cart_item[0] == coupons[:item]
      cart_item[1][:count] = cart_item[1][:count] - coupons[:num]
      
      couponed_cart[cart_item[0]] = cart_item[1]
      
      couponed_cart["#{cart_item[0]} W/COUPON"] = {
        :price => coupons[:cost],
        :clearance => cart_item[1][:clearance],
        :count => 1
      }
    else
      couponed_cart[cart_item[0]] = cart_item[1]
    end
  end
  couponed_cart
end
apply_coupons(cart2, coupon2)

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
