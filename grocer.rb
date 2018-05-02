require "pry"

def consolidate_cart(cart)
  new_hash = {}
  cart1 = cart.uniq

  cart1.each do |item_hash|
    item_hash.each do |item, attribute_hash|
      new_hash[item] = attribute_hash
      new_hash[item][:count] = cart.count(item_hash)
    end
  end
  new_hash
  cart = new_hash
  return cart
end


def apply_coupons(cart, coupons)
    coupons.each do |coupon|
      item = coupon[:item]
      if cart[item]
        if cart[item][:count] >= coupon[:num]
          cart["#{item} W/COUPON"] = {}
          cart["#{item} W/COUPON"][:price] = coupon[:cost]
          cart["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
          cart["#{item} W/COUPON"][:count] = 0
          while cart[item][:count] >= coupon[:num] do
              cart[item][:count] -= coupon[:num]
              cart["#{item} W/COUPON"][:count] += 1
          end
        end
      end
    end
  cart
end


def apply_clearance(cart)

  cart.each do |item, attribute_hash|

    if cart[item][:clearance] == true
      cart[item][:price] *= 0.8
      cart[item][:price] = cart[item][:price].round(2)
    end
  end
  cart

end


def checkout(cart, coupons)

  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  cleared_cart = apply_clearance(couponed_cart)


  total = 0

  cleared_cart.each do |item, attribute_hash|
    total += attribute_hash[:price] * attribute_hash[:count]
  end

  if total > 100
    total *= 0.9
    total = total.round(2)
  end

return total


end
