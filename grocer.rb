require 'pry'
def consolidate_cart(cart)
  new_hash = {}
  cart.each do |hash|
    hash.each do |key, value|
      if new_hash.keys.include?(key)
        new_hash[key][:count] += 1

      else
        new_hash[key] = value
        new_hash[key][:count] = 1

      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
    coupons.each do |hash|
        item_var = hash[:item]
        if cart[item_var] && cart[item_var][:count] >= hash[:num]
          if cart["#{item_var} W/COUPON"]
            cart["#{item_var} W/COUPON"][:count] += cart[item_var][:count] / hash[:num]
          else
              cart["#{item_var} W/COUPON"] = {
                                                :clearance => cart[item_var][:clearance],
                                                :count => (cart[item_var][:count] / hash[:num]),
                                                :price => hash[:cost]
                                              }
          end
          cart[item_var][:count] = cart[item_var][:count] % hash[:num]
        end
    end
    cart
end




def apply_clearance(cart)
  cart.each do |key, value|
    if cart[key][:clearance] == true
      cart[key][:price] = cart[key][:price] * 0.80
      cart[key][:price] = cart[key][:price].round(2)
    end
  end
end



def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  new_cart_coupon = apply_coupons(new_cart, coupons)
  new_cart_clearance = apply_clearance(new_cart_coupon)
  total_price = 0
    new_cart_clearance.each do |key, value|
      total_price += new_cart_clearance[key][:price] * new_cart_clearance[key][:count]
    end
  if total_price > 100
    total_price = total_price * 0.9
  end
    total_price.round(2)
end
