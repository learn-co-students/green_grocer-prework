def consolidate_cart(cart)
  # code here
  cart.each_with_object({}) do |item, hash|
    item.each do |type, attributes|
      if hash[type]
        attributes[:count] += 1
      else
        attributes[:count] = 1
        hash[type] = attributes
      end
    end
  end
end

def apply_coupons(cart, coupons)
  # code here
  items = cart.keys
  coupons.each do |coupon|
    next if !items.include?(coupon[:item])
    first = true
    while coupon[:num] <= cart[coupon[:item]][:count]
      cart[coupon[:item]][:count] -= coupon[:num]
      if first
        cart["#{coupon[:item]} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => cart[coupon[:item]][:clearance],
          :count => 1
        }
      else
        cart["#{coupon[:item]} W/COUPON"][:count] += 1
      end
      first = false
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, details|
    if details[:clearance]
      details[:price] -= 0.2 * details[:price]
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total = 0
  cart.each do |item, details|
    total += (details[:price] * details[:count])
  end
  if total > 100
    total -= (total * 0.10)
  end
  total
end
