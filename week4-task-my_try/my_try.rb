class Object
  def my_try(*a, &b)
     if a.empty? && block_given?
       yield self
     else
       send(*a, &b) if respond_to?(a.first)
     end
   end
end

# Вот такая вот глупая копипаста получилась =\ Сколько раз моя реализация
# не сработала как нужно - промолчу.
