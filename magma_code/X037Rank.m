/*
    X037Rank.m

    This script generates analytic ranks of the two isogeny factors
    of J0(37) for triaging which quadratic fields K we can determine
    the K-points on X0(37)

*/

E1 := EllipticCurve("37a1");
E2 := EllipticCurve("37b2");

DRANGE := 100;  // the range of d to compute

function Verdict(RankE1Tot, RankE2Tot)

    RankTotal := RankE1Tot + RankE2Tot;
    if RankE2Tot eq 0 then
        return "easy: E2 has rank 0";
    elif RankTotal le 3 then
        return "CC";
    elif RankTotal eq 4 then
        return "QC";
    else
        return "TBD";
    end if;
end function;

QCVALS := [];

for d in [-DRANGE..DRANGE] do
    if d ne 1 then
        if d ne 0 then
            if IsSquarefree(d) then
                RankE1tw := AnalyticRank(QuadraticTwist(E1,d));
                RankE2tw := AnalyticRank(QuadraticTwist(E2,d));
                RankE1Tot := 1 + RankE1tw;
                RankE2Tot := RankE2tw;
                RankTot := RankE1Tot + RankE2Tot;
                verdict := Verdict(RankE1Tot, RankE2Tot);

                if verdict eq "QC" then
                    Append(~QCVALS, d);
                end if;

                Write("X037RankData.txt", Sprintf("%o: %o, %o, %o, %o", d, RankE1Tot, RankE2Tot, RankTot, verdict));
            end if;
        end if;
    end if;
end for;