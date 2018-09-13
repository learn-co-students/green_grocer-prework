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


def apply_coupons(cart, coupons)
  if coupons != []
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
    couponed_cart
  else
    cart
  end
end

def apply_clearance(cart)
  # code here
  cart.collect do |cart_item|
    if cart_item[1][:clearance]== true
      cart_item[1][:price] = (cart_item[1][:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
end
