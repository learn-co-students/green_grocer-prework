require 'pry'

def consolidate_cart(array)

    c_cart = {}

    array.each do |items|

        items.each do |item, dets|

            if c_cart.include?(item)

                c_cart[item][:count] += 1

            else

                c_cart[item] = dets
                c_cart[item][:count] = 1
            end
        end
    end
    c_cart
end

def apply_coupons(array, coupons)

    coupons.each do |coupon|

        item = coupon[:item]

        if array.include?(item)

            if array[item][:count] >= coupon[:num]

                array[item][:count] -= coupon[:num]

                if array.include?("#{item} W/COUPON")

                    array["#{item} W/COUPON"][:count] += 1
                else

                    array["#{item} W/COUPON"] = {price: coupon[:cost], clearance: array[item][:clearance], count: 1}

                end
            end
        end
    end
    array
end

def apply_clearance(array)

    array.each do |item, v|

        if v[:clearance]

            v[:price] = (v[:price] * 0.8).round(2)

        end
    end
end

def checkout(array, coupons)

array = consolidate_cart(array)

array = apply_coupons(array, coupons)

array = apply_clearance(array)

final = 0

    array.each do |k, v|

        final += v[:price] * v[:count]
    end

    if final > 100

        final *= 0.9

    end
    final
end
