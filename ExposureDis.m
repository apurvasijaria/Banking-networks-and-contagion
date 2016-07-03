function [approx]=ExposureDis (dom_node, int_node, countries, bankclaims )

% approximating the individual bank-to-bank claims by dividing
% the aggregated claims of all domestic banks by the number of UK banks (17) and
% the number of international banks per country (12).
approx= bankclaims./ (dom_node+ (int_node/countries));

end

