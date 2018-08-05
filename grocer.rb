def consolidate_cart(cart)
  cart.each_with_object({}) do |item, hash|
    item.each do |product, attributes|
      hash[product] = attributes
      hash[product][:count] ||= 0
      hash[product][:count] += 1
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coup_item = coupon[:item]
    break if !cart[coup_item]
    usable_coupons = cart[coup_item][:count] / coupon[:num]
    if usable_coupons > 0
      cart[coup_item][:count] -= usable_coupons * coupon[:num]
      cart["#{coup_item} W/COUPON"] = 
        {
          :price => coupon[:cost],
          :clearance => cart[coup_item][:clearance],
          :count => usable_coupons
        }
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |product, attributes|
    if attributes[:clearance] == true
      attributes[:price] = (attributes[:price] *= 0.80).round(2)
    end
  end
end

def total_cart(cart)
  total = 0
  cart.each do |product, attributes|
    total += attributes[:price] * attributes[:count]
  end
  total
end
  
def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart = total_cart(cart)
  if cart > 100
    cart *= 0.90
  end
  cart
end
