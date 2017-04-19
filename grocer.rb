
def consolidate_cart(cart)
  result = {}
  cart.each do |item|
    item.each do |product, attributes |
      if result[product]
        result[product][:count] += 1
      else
        result[product] = attributes
        result[product][:count] = 1
      end
    end
  end

  result
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
          cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
       cart[name][:count] -= coupon[:num]
     end
  end

  cart
  # code here
end

def apply_clearance(cart)
  cart.each do | item, attributes |
    if attributes[:clearance]
      attributes[:price] = (attributes[:price] * 0.80).round(2)
    end
  end
  # code here
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  after_coupons = apply_coupons(consolidated_cart, coupons)
  after_clearance = apply_clearance(after_coupons)

  total = 0

  after_clearance.each do | item, attributes |
    total += attributes[:price] * attributes[:count]
  end

  total > 100 ? total * 0.9 : total
end
