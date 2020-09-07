class KMeansSegmentation {
  PGraphics image;
  int num_clusters;
  color[] cluster_colors;
  int[][] cluster_assignments;
    KMeansSegmentation(PGraphics pg, int n) {
    image = pg;
    num_clusters = n;
    cluster_colors = new color[num_clusters];
    cluster_assignments = new int[image.width][image.height];
    for (int i = 0; i < n; i++)
      cluster_colors[i] = color(255, 255, 255);
    for (int x = 0; x <image.width; x++)
      for (int y = 0; y < image.height; y++)
        cluster_assignments[x][y] = -1;
  }
  int iteration() {
    int changed = 0;
    int[] totals = new int[num_clusters];
    float[][] ctotals = new float[num_clusters][3];
    for (int i = 0; i < num_clusters; i++) {
      totals[i] = 0;
      ctotals[i][0] = 0;
      ctotals[i][1] = 0;
      ctotals[i][2] = 0;
    }
    for (int x = 0; x < image.width; x++) {
      for (int y = 0; y < image.height; y++) {
        int curr_cluster = cluster_assignments[x][y];
        color pixel_color = image.pixels[y * image.width + x];
        double closest_distance = 999999999;
        int closest_cluster = -1;
        for (int i = 0; i < num_clusters; i++) {
          
          color cluster_color = cluster_colors[i];

          double dist = cdist2(pixel_color, cluster_color);

          if (dist < closest_distance) {
            closest_distance = dist;
            closest_cluster = i;
          }
        }


        cluster_assignments[x][y] = closest_cluster;

        ctotals[closest_cluster][0] += red(pixel_color);
        ctotals[closest_cluster][1] += green(pixel_color);
        ctotals[closest_cluster][2] += blue(pixel_color);
 
        totals[closest_cluster]++;

     
        if (closest_cluster != curr_cluster)
          changed++;
      }
    }

    for (int i = 0; i < num_clusters; i++) {
      cluster_colors[i] = color(
        ctotals[i][0] / totals[i],
        ctotals[i][1] / totals[i],
        ctotals[i][2] / totals[i]
      );
    }

    return changed;
  }
  PGraphics overlay() {
  PGraphics o = createGraphics(image.width, image.height);
  o.beginDraw();
  o.loadPixels();

  for (int x = 0; x < o.width; x++) {
    for (int y = 0; y < o.height; y++) {
      int cluster = cluster_assignments[x][y];
      int c = cluster_colors[cluster];
        //println(cluster_colors);
      o.pixels[y*o.width + x] = c;
    }
  }

  o.updatePixels();
  o.endDraw();

  return o;
}

};
double cdist2(color a, color b) {
  float rbar = (red(a) + red(b)) / 2;
  float deltar = red(a) - red(b);
  float deltag = green(a) - green(b);
  float deltab = blue(a) - blue(b);
  float deltac = sqrt(
                    2 * sq(deltar) +
                    4 * sq(deltag) +
                    3 * sq(deltab) +
                    (rbar + (sq(deltar) - sq(deltab)))/256);
  return deltac;
}
