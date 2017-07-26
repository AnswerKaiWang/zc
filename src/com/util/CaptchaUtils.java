/**
 * 
 */
package com.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.concurrent.ThreadLocalRandom;

import javax.imageio.ImageIO;

/**
 * @author tyb
 * @date 2016年8月30日下午1:43:12
 * @desc
 */
public final class CaptchaUtils {
	private static final String VERIFY_CODES = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ";
	private static final ThreadLocalRandom rand = ThreadLocalRandom.current();

	public static void main(String[] args) throws IOException {
		System.out.println(getRandCode(6, VERIFY_CODES));
		FileOutputStream fos = new FileOutputStream(new File("D:\\captach.jpg"));
		gen(112, 37, fos, getRandCode(4, VERIFY_CODES));
	}
	
	public static String genDefaultCode(){
		return getRandCode(4,VERIFY_CODES);
	}
	
	private static String getRandCode(int length, String sources) {
		final int size = sources.length();
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < length; i++) {
			sb.append(sources.charAt(rand.nextInt(size)));
		}
		return sb.toString();
	}

	private static Color getRndColor(int fc, int bc) {
		if (fc > 255)
			fc = 255;
		if (bc > 255)
			bc = 255;
		int r = fc + rand.nextInt(bc - fc);
		int g = fc + rand.nextInt(bc - fc);
		int b = fc + rand.nextInt(bc - fc);
		return new Color(r, g, b);
	}

	private static int[] getRandomRgb() {
		int[] rgb = new int[3];
		for (int i = 0; i < 3; i++) {
			rgb[i] = rand.nextInt(255);
		}
		return rgb;
	}

	private static int getRandomIntColor() {
		int[] rgb = getRandomRgb();
		int color = 0;
		for (int c : rgb) {
			color = color << 8;
			color = color | c;
		}
		return color;
	}
	
	public static void gen(final int w, final int h, OutputStream os) throws IOException{
		gen(w, h, os,getRandCode(4, VERIFY_CODES));
	}
	
	public static void gen(final int w, final int h, OutputStream os, String code) throws IOException {
		final int verifySize = code.length();
		BufferedImage img = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
		Graphics2D g2d = img.createGraphics();
		g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
		Color[] colorSpaces = new Color[] { Color.WHITE, Color.CYAN, Color.GRAY, Color.LIGHT_GRAY, Color.MAGENTA,
				Color.ORANGE, Color.PINK, Color.YELLOW };
		Color[] colors = new Color[5];
		float[] fractions = new float[colors.length];
		ThreadLocalRandom rnd = ThreadLocalRandom.current();
		for (int i = 0; i < colors.length; i++) {
			colors[i] = colorSpaces[rnd.nextInt(colorSpaces.length)];
			fractions[i] = rnd.nextFloat();
		}
		Arrays.sort(fractions);
		// 边框
		g2d.setColor(Color.gray);
		g2d.fillRect(0, 0, w, h);

		// 背景色
		Color c = getRndColor(200, 250);
		g2d.setColor(c);
		g2d.fillRect(0, 2, w, h - 4);

		// 干扰线
		g2d.setColor(getRndColor(160, 200));
		for (int i = 0; i < 20; i++) {
			int x = rnd.nextInt(w - 1);
			int y = rnd.nextInt(h - 1);
			int xl = rnd.nextInt(6) + 1;
			int yl = rnd.nextInt(12) + 1;
			g2d.drawLine(x, y, x + xl + 40, y + yl + 20);
		}
		// 添加噪点
		float yawpRate = 0.05f;// 噪声率
		int area = (int) (yawpRate * w * h);
		for (int i = 0; i < area; i++) {
			int x = rnd.nextInt(w);
			int y = rnd.nextInt(h);
			int rgb = getRandomIntColor();
			img.setRGB(x, y, rgb);
		}

		shear(g2d, w, h, c);// 使图片扭曲
		//字体
		g2d.setColor(Color.red);
		int fontSize = h - 4;
		Font font = new Font("Algerian", Font.ITALIC, fontSize);
		g2d.setFont(font);
		char[] chars = code.toCharArray();
		for (int i = 0; i < verifySize; i++) {
			AffineTransform affine = new AffineTransform();
			affine.setToRotation(Math.PI / 4 * rand.nextDouble() * (rand.nextBoolean() ? 1 : -1),
					(w / verifySize) * i + fontSize / 2, h / 2);
			g2d.setTransform(affine);
			g2d.drawChars(chars, i, 1, ((w - 10) / verifySize) * i + 5, h / 2 + fontSize / 2 - 10);
		}
		g2d.dispose();
		ImageIO.write(img, "jpg", os);
	}

	private static void shear(Graphics g, int w1, int h1, Color color) {
		shearX(g, w1, h1, color);
		shearY(g, w1, h1, color);
	}

	private static void shearX(Graphics g, int w1, int h1, Color color) {
		int period = rand.nextInt(2);
		boolean borderGap = true;
		int frames = 1;
		int phase = rand.nextInt(2);
		for (int i = 0; i < h1; i++) {
			double d = (double) (period >> 1)
					* Math.sin((double) i / (double) period + (6.2831853071795862D * (double) phase) / (double) frames);
			g.copyArea(0, i, w1, 1, (int) d, 0);
			if (borderGap) {
				g.setColor(color);
				g.drawLine((int) d, i, 0, i);
				g.drawLine((int) d + w1, i, w1, i);
			}
		}

	}
	private static void shearY(Graphics g, int w1, int h1, Color color) {
		int period = rand.nextInt(40) + 10; // 50;
		boolean borderGap = true;
		int frames = 20;
		int phase = 7;
		for (int i = 0; i < w1; i++) {
			double d = (double) (period >> 1)
					* Math.sin((double) i / (double) period + (6.2831853071795862D * (double) phase) / (double) frames);
			g.copyArea(i, 0, 1, h1, 0, (int) d);
			if (borderGap) {
				g.setColor(color);
				g.drawLine(i, (int) d, i, 0);
				g.drawLine(i, (int) d + h1, i, h1);
			}

		}

	}
}
