require 'pry'
cart = [
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"KALE"    => {:price => 3.0, :clearance => false}}
]

def consolidate_cart(cart)
  # code here
  consolidated = {}
  cart.each do |x|
    x.each do |key, value|
      if !consolidated.include?(key)
        consolidated[key] = value
        consolidated[key][:count] = 1
      else
        consolidated[key][:count] += 1
      end
    end
  end
  return consolidated
end

# puts consolidate_cart(cart)

# other_cart = {
#   "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
#   "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
# }
other_cart = {
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 2}
}


coupons = [{:item => "AVOCADO", :num => 2, :cost => 5.0}]

def apply_coupons(cart, coupons)
  # code here
  coupons_applied = {}
  coupons.each do |coupons|
    cart.each do |key, value|
      if key.include?(coupons[:item])
        if value[:count] >= coupons[:num]
          coupons_applied["#{key} W/COUPON"] = {price: coupons[:cost], clearance: value[:clearance], count: 0}
          while value[:count] >= coupons[:num]
            coupons_applied["#{key} W/COUPON"][:count] += 1
            value[:count] -= coupons[:num]
          end
        end
      end
    end
  end
  coupons_applied.merge!(cart)
  return coupons_applied
end

# puts apply_coupons(other_cart, coupons)
# puts apply_coupons(other_cart)


def apply_clearance(cart)
  # code here
  cart.each do |key, value|
    if value[:clearance]
      value[:price] = (value[:price] * 0.8).round(2)
    end
  end

  return cart
end

def checkout(cart, coupons)
  # code here
  total = 0
  your_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  your_cart.each do |key, value|
    total += value[:price] * value[:count]
  end
  if total > 100
    total = total * 0.9
  end
  return total
end
