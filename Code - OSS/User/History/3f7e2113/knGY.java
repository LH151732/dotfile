public class MutArray {

    public static void main(String[] args) {
        // 创建一个 5x5 的二维数组，默认所有值为 0
        int[][] array = new int[5][5];

        // 用两个 for 循环遍历每个元素
        for (int i = 0; i < array.length; i++) {          // 外循环: 遍历行
            for (int j = 0; j < array[i].length; j++) {   // 内循环: 遍历列
                System.out.print(array[i][j] + " ");       // 打印每个元素并加空格
            }
            System.out.println();                          // 每行打印完后换行
        }
    }
}
