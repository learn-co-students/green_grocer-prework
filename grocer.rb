def consolidate_cart(cart)
  grocery_cart = {}
  count = 0 
  cart.each do |item|
    item.each do |food, details|
      details[:count] ||= 0
      details[:count] += 1
      grocery_cart[food] = details
    end
  end
  grocery_cart
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_key = coupon[:item]
    if cart.has_key?(item_key) 
      if cart[item_key][:count] >= coupon[:num]
        cart["#{item_key} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => cart[item_key][:clearance],
          :count => cart[item_key][:count] / coupon[:num]
        }
        cart[item_key][:count] = cart[item_key][:count] % coupon[:num]
        end
      end
   end
   cart
end

def apply_clearance(cart)
  cart.each do |item, details|
    if details[:clearance]
      discount = (details[:price] * 0.20) 
      details[:price] = details[:price] - discount
    end
  end
end

def checkout(cart, coupons)
  total = 0
  cart_hash = consolidate_cart(cart)
    if cart_hash.length >= 1
    coupons2 = apply_coupons(cart_hash, coupons)
      apply_clearance(coupons2).each do |item, details|
        total += details[:price] * details[:count]
        if total >= 100
          newTotal = total * 0.10
          total = total - newTotal
        end
    end
  end
  return total
end
