def consolidate_cart(cart)
  count_h = {}
  cart.each do |a|
    a.each do |k, v|
      if !count_h.key?(k)
        count_h[k] = {:count => 1}
      else
        count_h[k][:count] += 1
      end
    end
  end
  cart.each do |a|
    a.each do |k, v|
      v.each do |m, n|
        count_h.each do |c, d|
          if k == c
            count_h[c][m] = n
          end
        end
      end
    end
  end
  cart = count_h
  cart
end

def apply_coupons(cart, coupons)
  discounted_h = {}
  cart.each do |a, b|
    b.each do |c, d|
      coupons.each do |k, v|
        if !discounted_h.key?(a)
          if a != v
            discounted_h[a] = b
          elsif a == v
            undiscounted_c = cart[a][:count] - coupons[:num]
            discounted_h[a] =
              {price: cart[a][:price],
              clearance: cart[a][:clearance],
              count: undiscounted_c}
            discounted_h["#{a} W/COUPON"] =
              {price: coupons[:cost],
              clearance: cart[a][:clearance],
              count: 1}
          end
        end
      end
    end
  end
  discounted_h.each do |a, b|
    b.each do |k, v|
      if v == 0
        discounted_h.reject! { |x| x == a }
      end
    end
  end
  discounted_h
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
