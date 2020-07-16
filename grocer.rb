require 'pry'
def consolidate_cart(cart)
  # code here
  newcart = {}
  cart.each do |item|
    item.each do |name, val|
      if !newcart[name]
        newcart[name] = val
        newcart[name][:count] = 1
    elsif newcart[name]
      newcart[name][:count] +=1
      end
      end
  end
  #binding.pry
  return newcart
end



def apply_coupons(cart, coupons)
  coupons.each do |coup|
     coupname = coup[:item]
      #binding.pry
      if cart[coupname] && cart[coupname][:count] >= coup[:num]
        if cart["#{coupname} W/COUPON"]
          cart["#{coupname} W/COUPON"][:count] = cart["#{coupname} W/COUPON"][:count] + 1
        else
          cart["#{coupname} W/COUPON"] = {:count => 1,
                                          :price => coup[:cost]
                                        }
          cart["#{coupname} W/COUPON"][:clearance] =cart[coupname][:clearance]
        end

        cart[coupname][:count] = cart[coupname][:count] -  coup[:num]
      end

  end
return cart
  # code here
end

def apply_clearance(cart)
  cart.each do |name, item|
    if item[:clearance] == true
      price = item[:price] * 0.80
      item[:price] = price.round(2)
    end
  end
  # code here

  return cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  price = 0
  cart.each do | name, item |
    price += item[:price] * item[:count]
  end
  if price > 100
      price = price * 0.90
  end
  return price
  # code here
end
