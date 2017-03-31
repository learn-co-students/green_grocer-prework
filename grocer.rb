def consolidate_cart(cart)
  cart.each_with_object({}) do |items, new_hash|
    items.each do |item, data|
      if !new_hash[item]
        data[:count] = 1
        new_hash[item] = data
      else
        data[:count] += 1
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]

    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => cart[name][:clearance],
          :count => 1
        }
      end
      cart[name][:count] -= coupon[:num]
    end
  end

  cart
end

def apply_clearance(cart)
  cart.each do |item, data|
    if data[:clearance]
      data[:price] = data[:price] - (data[:price] * 0.2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cons_cart = consolidate_cart(cart)
  couponed = apply_coupons(cons_cart, coupons)
  final = apply_clearance(couponed)

  total = 0
  final.each { |item, data| total += data[:price] * data[:count] }
  total = total - (total * 0.1) if total > 100
  total
end
