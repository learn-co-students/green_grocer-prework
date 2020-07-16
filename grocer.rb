def consolidate_cart(cart)

  newHash = {}

  cart.each do |elem|
    elem.each do |key, value|
      if newHash[key] == nil
        newHash[key] = value
        newHash[key][:count] = 1
      else
        newHash[key][:count] += 1
      end
    end
  end

  return newHash
end

def apply_coupons(cart, coupons)

  keys = cart.keys
  newHash = {}
  keys.each do |elem|
      newHash[elem] = {}
  end

  cart.each do |key, value|
      newHash[key] = value
  end

  coupons.each do |elem|

      item_ = elem[:item]
      num_ = elem[:num]
      cost_ = elem[:cost]

      if newHash[item_] != nil
          new_num = newHash[item_][:count] - num_
          if newHash["#{item_} W/COUPON"] == nil
            newHash["#{item_} W/COUPON"] = {:price => cost_, :clearance => cart[item_][:clearance], :count => 1}
            newHash[item_][:count] = new_num
          else
            if new_num >= 0
              newHash["#{item_} W/COUPON"][:count] += 1
              newHash[item_][:count] = new_num
            end


          end
        end
  end

  return newHash
end

def apply_clearance(cart)

  cart.each do |key, value|

      if cart[key][:clearance] == true
        cart[key][:price] *= 0.8
        cart[key][:price] = cart[key][:price].round(2)
      end
  end

  return cart
end

def checkout(cart, coupons)

  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)


  price = 0
  cart.each do |key, value|
    puts key
    puts value
    if value[:count]>0
      price += value[:price]*value[:count]
    end
  end

  if price > 100

    price = price*0.9
    price = price.round(2)
  end

  return price

end
