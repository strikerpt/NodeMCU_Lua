
-- source: https://fr.wikipedia.org/wiki/Expression_r%C3%A9guli%C3%A8re

--règle regex remplacer ça: (%w+)=(%w+)&* par la règle qui suit:

-- le mot qui se trouve à gauche du = tout ce qui se trouve à droite du = jusqu'au & ou return

vars="htext=hello+zuzu&hinput=Valider"
for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
        _GET[k] = v
        print(k..": "..v)
end

--Résultat:
--htext: hello+zuzu
--input: Valider


