def consolidate_cart(cart)
  # code here
  counts = cart.uniq
  consolidated = {}
  counts.each do |obj|
      count = cart.count(obj)
      key,value = obj.first
      obj[key][:count] = count
      consolidated[key] = obj[key]
  end
  consolidated


end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
      food = coupon[:item]
      # coupon applies to cart

      if cart.has_key?(food)
          # what if coupon
          if !food.include?("W/COUPON")



              #cart has more than coupon applies for, leave leftovers in cart
              puts "*****"
              puts cart
              puts coupon
              puts "----"
              if cart[food][:count] >= coupon[:num]
                  cart[food][:count] -= coupon[:num]
                    # keep as 0
                    # elsif cart[food][:count] == coupon[:num]
                    wcoupon = food + " W/COUPON"

                    #coupon already exists?
                    if cart.has_key?(wcoupon)
                        cart[wcoupon][:count] +=1
                    else

                        cart[wcoupon] = cart[food].clone

                        cart[wcoupon][:price] = coupon[:cost]
                        cart[wcoupon][:count] = 1
                    end

              end
              # less than means coupon doesnt apply
              puts cart
          end

      end
  end
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
