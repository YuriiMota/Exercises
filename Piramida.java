package epam;

public class Piramida {
    public static void main(String args[]){
        String S="12345677654321";
        int k = S.length();
        int w=k/2;

        String word="";
        if (k%2==0) {
            for (int i = w, j = w; i > 0; i--, j++) {
                for (int l = i - 1; l > 0; l--)
                    System.out.print(" ");
                word = S.charAt(i - 1) + word + S.charAt(j);
                System.out.println(word);

            }
            for (int d = 1; d < k - 1; d++, k--) {
                word = "";
                for (int l = 0; l < d; l++)
                    System.out.print(" ");
                for (int i = d; i < k - 1; i++) {

                    word = word + S.charAt(i);

                }
                System.out.println(word);
            }
        }
        else {
            word = Character.toString(S.charAt(w));
            for (int l = w ; l > 0; l--)
                System.out.print(" ");
            System.out.println(word);
            for (int i = w, j = w; i > 0; i--, j++) {
                for (int l = i - 1; l > 0; l--)
                    System.out.print(" ");
                word = S.charAt(i - 1) + word + S.charAt(j+1);
                System.out.println(word);

            }
            for (int d = 1; d < k - 1; d++, k--) {
                word = "";
                for (int l = 0; l < d; l++)
                    System.out.print(" ");
                for (int i = d; i < k - 1; i++) {

                    word = word + S.charAt(i);

                }
                System.out.println(word);
            }
        }
    }
}
