require 'pry'

def consolidate_cart(cart)
  keys = cart.collect do |key|
    key.keys
  end
  cart.each do |k,v|
    k.values[0].store(:count, keys.count(k.keys))
  end
  new_cart = {}
  cart.uniq.each do |hash|
    new_cart.merge!(hash)
  end
  new_cart
end


def apply_coupons(cart, coupons)
  if coupons != []
    new_cart = {}.merge(cart)
    new_hash = coupons

    new_hash.each do |hash|
      if new_cart.keys.include?(hash[:item])
        item_2 = hash[:item]
        item = "#{hash[:item]} W/COUPON"
        new_hash = {item => hash}
        new_cart.merge!(new_hash)

        new_cart[item].delete(:item)
        new_cart[item][:price] = new_hash[item][:cost]
        new_cart[item][:clearance] = new_cart[item_2][:clearance]
        new_cart[item][:count] = new_cart[item_2][:count] / new_hash[item][:num]

        new_cart[item_2][:count] -= new_hash[item][:num]*new_hash[item][:count]
        new_hash[item].delete(:num)
        new_hash[item].delete(:cost)
     end
   end
    new_cart
  else
    cart
  end
end


def apply_clearance(cart)
  cart.each do |k,v|
    if v[:clearance] === true
      v[:price] = (v[:price]*0.80).round(1)
    else
      v[:price] = v[:price]
    end
  end
end


def checkout(cart, coupons)

  cart = apply_coupons(consolidate_cart(cart), coupons)
  cart = apply_clearance(cart)

  total = 0
  cart.values.each do |k,v|
      total += (k[:price] * k[:count]).round(1)
  end

  if total > 100
    (total *= 0.90).round(1)
  end
  total.round(1)
end
