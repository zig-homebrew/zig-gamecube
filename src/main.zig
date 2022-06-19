const c = @import("gamecube/c.zig");

export fn main(_: c_int, _: [*]const [*:0]const u8) void {
    c.VIDEO_Init();
    const rmode: *c.GXRModeObj = c.VIDEO_GetPreferredMode(null);
    const xfb: *anyopaque = c.MEM_K0_TO_K1(c.SYS_AllocateFramebuffer(rmode)) orelse unreachable;
    c.console_init(xfb, 20, 20, rmode.fbWidth, rmode.xfbHeight, rmode.fbWidth * c.VI_DISPLAY_PIX_SZ);
    c.VIDEO_Configure(rmode);
    c.VIDEO_SetNextFramebuffer(xfb);
    c.VIDEO_SetBlack(false);
    c.VIDEO_Flush();
    c.VIDEO_WaitVSync();
    if (rmode.viTVMode & c.VI_NON_INTERLACE != 0) c.VIDEO_WaitVSync();

    _ = c.printf("Hello, Zig");
    while (true) {
        c.VIDEO_WaitVSync();
    }
}
