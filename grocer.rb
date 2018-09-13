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
coupon2 = [{:item => "CHEESE", :num => 2, :cost => 5.0}]
def apply_coupons(cart, coupons)
  # code here
  couponed_cart = {}
  cart.each do |cart_item|
    coupons.each do |each_coupon|
      if cart_item[0] == each_coupon[:item]
        #binding.pry
        cart_item[1][:count] = cart_item[1][:count] - each_coupon[:num]
        
        couponed_cart[cart_item[0]] = cart_item[1]
        if couponed_cart["#{cart_item[0]} W/COUPON"] == nil
          couponed_cart["#{cart_item[0]} W/COUPON"] = {
            :price => each_coupon[:cost],
            :clearance => cart_item[1][:clearance],
            :count => 1
          }
        else
          couponed_cart["#{cart_item[0]} W/COUPON"][:count] = couponed_cart["#{cart_item[0]} W/COUPON"][:count] + 1
        end
      else
        couponed_cart[cart_item[0]] = cart_item[1]
      end
    end
  end
  binding.pry
  couponed_cart
end
apply_coupons(cart2, coupon2)

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
