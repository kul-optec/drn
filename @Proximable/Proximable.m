classdef Proximable < handle
    methods
        function p = is_prox_accurate(obj)
            p = true;
        end
        function p = is_separable(obj)
            p = false;
        end
        function p = is_convex(obj)
            p = false;
        end
        function p = is_singleton(obj)
            p = false;
        end
        function p = is_cone(obj)
            p = false;
        end
        function p = is_affine(obj)
            p = obj.is_singleton();
        end
        function p = is_set(obj)
            p = obj.is_affine() || obj.is_cone();
        end
        function p = is_smooth(obj)
            p = false;
        end
        function p = is_quadratic(obj)
            p = false;
        end
        function p = is_generalized_quadratic(obj)
            p = obj.is_quadratic() || obj.is_affine();
        end
        function p = is_strongly_convex(obj)
            p = false;
        end
    end
end
