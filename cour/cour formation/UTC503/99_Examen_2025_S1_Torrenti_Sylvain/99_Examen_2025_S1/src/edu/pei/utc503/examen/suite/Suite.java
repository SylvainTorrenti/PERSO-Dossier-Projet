package edu.pei.utc503.examen.suite;

public class Suite {

	/**
	 * U0 = 2 U1 = 4 Un = 3 + Un-1 + 2 * Un-2
	 * 
	 * @param n
	 * @return
	 */
	public static Double termeN_Iter(Integer n) {
		double U0 = 2;
		double U1 = 4;
		double res = 0;

		for (int i = 2; i <= n; i++) {

		}
//			res = 3 + Ui-1 + 2*Ui-2;

		return res;
	}

	/**
	 * U0 = 2 U1 = 4 Un = 3 + Un-1 + 2 * Un-2
	 * 
	 * @param n
	 * @return
	 */
	public static Double termeN_Rec(Integer n) {

		if (n == 0) {
			return 1.00;
		} else {

			return termeN_Rec(n - 1);
		}
	}

	public static void main(String[] args) {
		for (int i = 0; i < 20; i++) {
			System.out.println("Iter -> U" + i + " = " + termeN_Iter(i));
//			System.out.println("Rec -> U" + i + " = " + termeN_Rec(i));
		}
	}

}
