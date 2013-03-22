?package 
{
    import ATFMake.*;
    import __AS3__.vec.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import flashx.textLayout.conversion.*;
    import mx.binding.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import spark.components.*;
    import spark.events.*;

    public class ATFMake extends WindowedApplication implements IBindingClient
    {
        private var _79906P_Q:HSlider;
        private var _79907P_R:CheckBox;
        private var _164873549radiogroup1:RadioButtonGroup;
        private var _936778969rdDXT5:RadioButton;
        private var _936378778rdRGBA:RadioButton;
        private var _3534394tOUT:TextArea;
        private var _3535662tP_Q:TextInput;
        private var __moduleFactoryInitialized:Boolean = false;
        private var Args:Vector.<String>;
        private var process:NativeProcess;
        private var appPath:String;
        private var loader:Loader;
        private var openfile:File;
        private var taskFileList:Array;
        private var taskFileMaxNum:int = 0;
        private var constSavefile:File;
        private var tempSavefile:File;
        private var welcome:String;
        private var lastInTime:int;
        private var lastTime:int;
        private var outStr:String = "";
        private var cmdFile:File;
        private var nativeProcessStartupInfo:NativeProcessStartupInfo;
        var _ATFMake_StylesInit_done:Boolean = false;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;
        private static var _skinParts:Object = {gripper:false, contentGroup:false, statusBar:false, statusText:false, controlBarGroup:false, titleBar:false};

        public function ATFMake()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this.Args = new Vector.<String>;
            this.loader = new Loader();
            this.taskFileList = [];
            this.constSavefile = new File("D:\\temp\\");
            this.tempSavefile = new File(this.constSavefile.nativePath);
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            var bindings:* = this._ATFMake_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_ATFMakeWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , function (param1:String)
            {
                return [param1];
            }// end function
            , bindings, watchers);
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.width = 920;
            this.height = 534;
            this.mxmlContentFactory = new DeferredInstanceFromFunction(this._ATFMake_Array1_c);
            this._ATFMake_RadioButtonGroup1_i();
            this.addEventListener("creationComplete", this.___ATFMake_WindowedApplication1_creationComplete);
            var i:uint;
            while (i < bindings.length)
            {
                
                Binding(bindings[i]).execute();
                i = (i + 1);
            }
            return;
        }// end function

        override public function set moduleFactory(param1:IFlexModuleFactory) : void
        {
            super.moduleFactory = param1;
            if (this.__moduleFactoryInitialized)
            {
                return;
            }
            this.__moduleFactoryInitialized = true;
            .mx_internal::_ATFMake_StylesInit();
            return;
        }// end function

        override public function initialize() : void
        {
            super.initialize();
            return;
        }// end function

        protected function windowedapplication1_creationCompleteHandler(event:FlexEvent) : void
        {
            var _loc_5:CSSStyleDeclaration = null;
            this.tempSavefile.createDirectory();
            var _loc_2:* = FlexGlobals.topLevelApplication.styleManager.selectors;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_5 = FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(_loc_2[_loc_3]);
                _loc_5.setStyle("fontFamily", "΢���ź�");
                _loc_5.setStyle("fontSize", "13");
                _loc_3++;
            }
            statusText.setStyle("fontSize", "13");
            this.welcome = "\n��ӭʹ����SunnyBoxs������ATFת�����ߣ�ʹ�÷������£�\n��1��֧���Ϸ�ת������һ��png,jpg��ʽ��ͼƬ�������У�������ͬĿ¼�����ATF��ʽ���ļ���\n��2������ͼƬת�����������ͼƬʵ��ת����\n��3������Ŀ¼ת�������԰�ĳ��Ŀ¼��(����Ŀ¼)��jpg.pngת������Ӧ��ATF��ʽ��\n\n����ѡ�֧��RGBA��DXT5��ʽ��֧��JPEG-XR+LZMAѹ����֧��ͼƬ�����������ڡ�\n\n��лʹ�ã����������뷴����SunnyBoxs��лл��";
            this.tOUT.text = this.welcome;
            var _loc_4:* = this.nativeWindow;
            this.nativeWindow.x = (Capabilities.screenResolutionX - _loc_4.width) / 2;
            _loc_4.y = (Capabilities.screenResolutionY - _loc_4.height) / 2;
            this.cmdFile = new File();
            this.cmdFile = this.cmdFile.resolvePath("C://WINDOWS//system32//cmd.exe");
            addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, this.onDragIn);
            addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, this.onDrop);
            this.restart();
            return;
        }// end function

        private function restart() : void
        {
            this.nativeProcessStartupInfo = new NativeProcessStartupInfo();
            this.nativeProcessStartupInfo.executable = this.cmdFile;
            arguments = new Vector.<String>;
            arguments.push("");
            this.nativeProcessStartupInfo.arguments = arguments;
            this.process = new NativeProcess();
            this.process.start(this.nativeProcessStartupInfo);
            this.process.addEventListener(NativeProcessExitEvent.EXIT, this.onExit);
            this.process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, this.onStandardOutputData);
            this.process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, this.onError);
            var _loc_3:* = File.applicationDirectory;
            var _loc_4:* = _loc_3.nativePath.replace(/([A-Z]:).*""([A-Z]:).*/g, "$1");
            this.appPath = _loc_3.nativePath;
            this.runCommand(_loc_4);
            this.runCommand("cd " + _loc_3.nativePath);
            return;
        }// end function

        public function onDragIn(event:NativeDragEvent) : void
        {
            NativeDragManager.acceptDragDrop(this);
            return;
        }// end function

        public function onDrop(event:NativeDragEvent) : void
        {
            var _loc_3:File = null;
            var _loc_4:String = null;
            var _loc_2:* = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
            if (_loc_2 && _loc_2.length == 1)
            {
                _loc_3 = _loc_2[0] as File;
                _loc_4 = _loc_3.extension.toLocaleUpperCase();
                if (_loc_4 == "PNG" || _loc_4 == "JPG")
                {
                    this.openfile = _loc_3;
                    this.onSelect();
                }
            }
            return;
        }// end function

        private function JPEG_TO_ATF(param1:File, param2:File) : void
        {
            var _loc_3:String = null;
            if (param1.exists)
            {
                this.lastInTime = getTimer();
                _loc_3 = "png2atf <?format?> <?-R?>  -q " + int(this.P_Q.value) + " -i  " + param1.nativePath + "  -o  " + this.getSaveFileName(param2);
                if (this.P_R.selected)
                {
                    _loc_3 = _loc_3.split("<?-R?>").join("-r");
                }
                else
                {
                    _loc_3 = _loc_3.split("<?-R?>").join("");
                }
                if (this.radiogroup1.selection == this.rdDXT5)
                {
                    _loc_3 = _loc_3.split("<?format?>").join(" -c d ");
                }
                else
                {
                    _loc_3 = _loc_3.split("<?format?>").join("");
                }
                this.runCommand(_loc_3);
                ;
            }
            return;
        }// end function

        protected function button1_clickHandler(event:MouseEvent) : void
        {
            this.openfile = File.desktopDirectory;
            var _loc_2:* = new FileFilter("Images (*.jpg, *.jpeg, *.png)", "*.jpg; *.jpeg;  *.png");
            this.openfile.addEventListener(Event.SELECT, this.onSelect);
            this.openfile.browseForOpen("Open", [_loc_2]);
            return;
        }// end function

        private function onSelect(event:Event = null) : void
        {
            var e:* = event;
            var fileByte:* = this.readFile(this.openfile);
            try
            {
                this.lastTime = getTimer();
                this.loader.unload();
                this.loader.loadBytes(fileByte);
                this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.image_completeHandler);
                this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.image_completeHandler);
                this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
                this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
            }
            catch (e:Error)
            {
                if (taskFileMaxNum > 0)
                {
                    nextTaskFile();
                }
                else
                {
                    Alert.show("�𻵻���Ч��ͼƬ��ʽ��ݣ�", "�ļ���ݴ���");
                }
            }
            return;
        }// end function

        protected function errorHandler(event:IOErrorEvent) : void
        {
            if (this.taskFileMaxNum > 0)
            {
                this.nextTaskFile();
            }
            return;
        }// end function

        private function image_completeHandler(event:Event) : void
        {
            var _loc_2:BitmapData = null;
            var _loc_4:ByteArray = null;
            this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.image_completeHandler);
            var _loc_3:* = Bitmap(this.loader.contentLoaderInfo.content).bitmapData;
            if (_loc_3)
            {
                _loc_2 = getFixBitmapData(_loc_3);
                _loc_3.dispose();
                _loc_4 = _loc_2.encode(_loc_2.rect, new PNGEncoderOptions());
                _loc_2.dispose();
                if (_loc_4 && _loc_4.length > 0)
                {
                    this.tempSavefile = new File(this.constSavefile.nativePath).resolvePath(this.openfile.name + ".temp");
                    this.saveFile(this.tempSavefile, _loc_4);
                    this.JPEG_TO_ATF(this.tempSavefile, this.openfile);
                }
            }
            return;
        }// end function

        private function readFile(param1:File) : ByteArray
        {
            var _loc_2:* = new ByteArray();
            var _loc_3:* = new FileStream();
            _loc_3.open(param1, FileMode.READ);
            _loc_3.readBytes(_loc_2, 0, _loc_3.bytesAvailable);
            _loc_3.close();
            return _loc_2;
        }// end function

        private function saveFile(param1:File, param2:ByteArray) : void
        {
            var _loc_3:* = new FileStream();
            _loc_3.open(param1, FileMode.WRITE);
            _loc_3.writeBytes(param2);
            _loc_3.close();
            param2.clear();
            return;
        }// end function

        private function readFilelist(param1:File) : Array
        {
            var _loc_4:File = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.getDirectoryListing();
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_4.isDirectory)
                {
                    _loc_2 = _loc_2.concat(this.readFilelist(_loc_4));
                    continue;
                }
                _loc_2.push(_loc_4);
            }
            return _loc_2;
        }// end function

        protected function button2_clickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = File.desktopDirectory;
            _loc_2.browseForDirectory("��ѡ��Ŀ¼");
            _loc_2.addEventListener(Event.SELECT, this.selectFileHandler);
            return;
        }// end function

        protected function selectFileHandler(event:Event) : void
        {
            var _loc_3:File = null;
            var _loc_4:String = null;
            this.taskFileList = [];
            var _loc_2:* = this.readFilelist(event.target as File);
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = _loc_3.extension.toLocaleUpperCase();
                if (_loc_4 == "PNG" || _loc_4 == "JPG")
                {
                    this.taskFileList.push(_loc_3);
                }
            }
            this.taskFileMaxNum = this.taskFileList.length;
            if (this.taskFileMaxNum > 0)
            {
                this.nextTaskFile();
            }
            return;
        }// end function

        private function nextTaskFile() : void
        {
            if (this.taskFileList && this.taskFileList.length > 0)
            {
                this.openfile = this.taskFileList.pop() as File;
                this.onSelect();
            }
            else if (this.taskFileMaxNum > 0)
            {
                Alert.show("ת�����!���ƣ�" + this.taskFileMaxNum + "���ļ���");
            }
            return;
        }// end function

        private function runCommand(param1:String) : void
        {
            this.process.standardInput.writeMultiByte(param1 + "\n", "gb2312");
            return;
        }// end function

        private function onExit(event:NativeProcessExitEvent) : void
        {
            this.tOUT.text = this.tOUT.text + "\n[onExit]";
            this.tOUT.scroller.verticalScrollBar.value = this.tOUT.scroller.verticalScrollBar.maximum;
            return;
        }// end function

        private function onError(event:ProgressEvent) : void
        {
            var _loc_2:* = event.target as NativeProcess;
            var _loc_3:* = _loc_2.standardError.readMultiByte(_loc_2.standardError.bytesAvailable, "gb2312");
            this.tOUT.text = this.tOUT.text + (_loc_3 + "");
            this.tOUT.scroller.verticalScrollBar.value = this.tOUT.scroller.verticalScrollBar.maximum;
            return;
        }// end function

        private function onStandardOutputData(event:ProgressEvent) : void
        {
            var _loc_2:* = event.target as NativeProcess;
            var _loc_3:* = _loc_2.standardOutput.readMultiByte(_loc_2.standardOutput.bytesAvailable, "gb2312");
            _loc_3 = (_loc_3 + "").split(this.appPath).join("");
            _loc_3 = _loc_3.replace(/\s\
n""\s\n/gm, "");
            var _loc_4:* = /(\[In.*\])""(\[In.*\])/g;
            _loc_3 = _loc_3.replace(_loc_4, "$1<br>");
            if (_loc_4.test(_loc_3))
            {
                if (this.taskFileList.length > 0)
                {
                    this.outStr = "";
                }
                else
                {
                    this.outStr = this.outStr + ("<font color=\'#00FF00\'>ATFת����ɣ�" + this.openfile.nativePath + " --> <font color=\'#00FFFF\'>" + this.getSaveFileName(this.openfile) + "</font></font><br><font color=\'#CCCCCC\'>" + _loc_3 + "</font>");
                }
                if (this.taskFileList.length == 0)
                {
                    this.tOUT.textFlow = TextConverter.importToFlow(this.outStr, TextConverter.TEXT_FIELD_HTML_FORMAT);
                    this.tOUT.validateNow();
                    this.tOUT.scroller.verticalScrollBar.value = this.tOUT.scroller.verticalScrollBar.maximum;
                }
                else
                {
                    this.tOUT.text = "[" + (this.taskFileMaxNum - this.taskFileList.length + 1) + "/" + this.taskFileMaxNum + "] --> " + this.openfile.nativePath + "\n" + _loc_3.split("<br>").join("");
                }
                this.lastInTime = getTimer();
                if (this.tempSavefile.exists)
                {
                    try
                    {
                        this.tempSavefile.deleteDirectoryAsync();
                    }
                    catch (e:Error)
                    {
                    }
                }
                this.nextTaskFile();
            }
            return;
        }// end function

        private function getSaveFileName(param1:File) : String
        {
            return param1.nativePath.substr(0, param1.nativePath.lastIndexOf(".")) + ".atf";
        }// end function

        protected function tP_Q_changeHandler(event:TextOperationEvent) : void
        {
            this.P_Q.value = int(this.tP_Q.text);
            return;
        }// end function

        protected function button3_clickHandler(event:MouseEvent) : void
        {
            this.outStr = "";
            this.tOUT.text = this.welcome;
            return;
        }// end function

        private function _ATFMake_RadioButtonGroup1_i() : RadioButtonGroup
        {
            var _loc_1:* = new RadioButtonGroup();
            _loc_1.initialized(this, "radiogroup1");
            this.radiogroup1 = _loc_1;
            BindingManager.executeBindings(this, "radiogroup1", this.radiogroup1);
            return _loc_1;
        }// end function

        private function _ATFMake_Array1_c() : Array
        {
            var _loc_1:Array = [this._ATFMake_TextArea1_i(), this._ATFMake_Button1_c(), this._ATFMake_Button2_c(), this._ATFMake_RadioButton1_i(), this._ATFMake_RadioButton2_i(), this._ATFMake_HSlider1_i(), this._ATFMake_Label1_c(), this._ATFMake_CheckBox1_i(), this._ATFMake_Button3_c(), this._ATFMake_TextInput1_i()];
            return _loc_1;
        }// end function

        private function _ATFMake_TextArea1_i() : TextArea
        {
            var _loc_1:* = new TextArea();
            _loc_1.x = 0;
            _loc_1.y = 45;
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = 100;
            _loc_1.editable = false;
            _loc_1.setStyle("color", 16513529);
            _loc_1.setStyle("contentBackgroundColor", 131586);
            _loc_1.id = "tOUT";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.tOUT = _loc_1;
            BindingManager.executeBindings(this, "tOUT", this.tOUT);
            return _loc_1;
        }// end function

        private function _ATFMake_Button1_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.x = 552;
            _loc_1.y = 7;
            _loc_1.width = 56;
            _loc_1.height = 30;
            _loc_1.label = "����";
            _loc_1.addEventListener("click", this.___ATFMake_Button1_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___ATFMake_Button1_click(event:MouseEvent) : void
        {
            this.button3_clickHandler(event);
            return;
        }// end function

        private function _ATFMake_Button2_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.x = 616;
            _loc_1.y = 7;
            _loc_1.width = 112;
            _loc_1.height = 30;
            _loc_1.label = "��ͼƬתATF";
            _loc_1.addEventListener("click", this.___ATFMake_Button2_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___ATFMake_Button2_click(event:MouseEvent) : void
        {
            this.button1_clickHandler(event);
            return;
        }// end function

        private function _ATFMake_RadioButton1_i() : RadioButton
        {
            var _loc_1:* = new RadioButton();
            _loc_1.x = 12;
            _loc_1.y = 11;
            _loc_1.label = "RGBA";
            _loc_1.groupName = "radiogroup1";
            _loc_1.selected = true;
            _loc_1.id = "rdRGBA";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.rdRGBA = _loc_1;
            BindingManager.executeBindings(this, "rdRGBA", this.rdRGBA);
            return _loc_1;
        }// end function

        private function _ATFMake_RadioButton2_i() : RadioButton
        {
            var _loc_1:* = new RadioButton();
            _loc_1.groupName = "radiogroup1";
            _loc_1.x = 74;
            _loc_1.y = 11;
            _loc_1.label = "DXT5";
            _loc_1.id = "rdDXT5";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.rdDXT5 = _loc_1;
            BindingManager.executeBindings(this, "rdDXT5", this.rdDXT5);
            return _loc_1;
        }// end function

        private function _ATFMake_HSlider1_i() : HSlider
        {
            var _loc_1:* = new HSlider();
            _loc_1.x = 199;
            _loc_1.y = 16;
            _loc_1.width = 109;
            _loc_1.maximum = 180;
            _loc_1.minimum = 0;
            _loc_1.stepSize = 1;
            _loc_1.value = 30;
            _loc_1.id = "P_Q";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.P_Q = _loc_1;
            BindingManager.executeBindings(this, "P_Q", this.P_Q);
            return _loc_1;
        }// end function

        private function _ATFMake_Label1_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.x = 135;
            _loc_1.y = 15;
            _loc_1.text = "ͼƬƷ�ʣ�";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _ATFMake_CheckBox1_i() : CheckBox
        {
            var _loc_1:* = new CheckBox();
            _loc_1.x = 368;
            _loc_1.y = 11;
            _loc_1.label = "����JPEG-XR+LZMAѹ��";
            _loc_1.enabled = true;
            _loc_1.selected = true;
            _loc_1.id = "P_R";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.P_R = _loc_1;
            BindingManager.executeBindings(this, "P_R", this.P_R);
            return _loc_1;
        }// end function

        private function _ATFMake_Button3_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.x = 734;
            _loc_1.y = 7;
            _loc_1.width = 179;
            _loc_1.height = 30;
            _loc_1.label = "Ŀ¼����תATF(����Ŀ¼)";
            _loc_1.addEventListener("click", this.___ATFMake_Button3_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___ATFMake_Button3_click(event:MouseEvent) : void
        {
            this.button2_clickHandler(event);
            return;
        }// end function

        private function _ATFMake_TextInput1_i() : TextInput
        {
            var _loc_1:* = new TextInput();
            _loc_1.x = 314;
            _loc_1.y = 9;
            _loc_1.width = 44;
            _loc_1.addEventListener("change", this.__tP_Q_change);
            _loc_1.id = "tP_Q";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.tP_Q = _loc_1;
            BindingManager.executeBindings(this, "tP_Q", this.tP_Q);
            return _loc_1;
        }// end function

        public function __tP_Q_change(event:TextOperationEvent) : void
        {
            this.tP_Q_changeHandler(event);
            return;
        }// end function

        public function ___ATFMake_WindowedApplication1_creationComplete(event:FlexEvent) : void
        {
            this.windowedapplication1_creationCompleteHandler(event);
            return;
        }// end function

        private function _ATFMake_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : String
            {
                var _loc_1:* = int(P_Q.value) + "";
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "tP_Q.text");
            return result;
        }// end function

        function _ATFMake_StylesInit() : void
        {
            var _loc_1:CSSStyleDeclaration = null;
            var _loc_2:Array = null;
            var _loc_3:Array = null;
            var _loc_4:CSSCondition = null;
            var _loc_5:CSSSelector = null;
            if (mx_internal::_ATFMake_StylesInit_done)
            {
                return;
            }
            mx_internal::_ATFMake_StylesInit_done = true;
            styleManager.initProtoChainRoots();
            return;
        }// end function

        override protected function get skinParts() : Object
        {
            return _skinParts;
        }// end function

        public function get P_Q() : HSlider
        {
            return this._79906P_Q;
        }// end function

        public function set P_Q(param1:HSlider) : void
        {
            var _loc_2:* = this._79906P_Q;
            if (_loc_2 !== param1)
            {
                this._79906P_Q = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "P_Q", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get P_R() : CheckBox
        {
            return this._79907P_R;
        }// end function

        public function set P_R(param1:CheckBox) : void
        {
            var _loc_2:* = this._79907P_R;
            if (_loc_2 !== param1)
            {
                this._79907P_R = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "P_R", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get radiogroup1() : RadioButtonGroup
        {
            return this._164873549radiogroup1;
        }// end function

        public function set radiogroup1(param1:RadioButtonGroup) : void
        {
            var _loc_2:* = this._164873549radiogroup1;
            if (_loc_2 !== param1)
            {
                this._164873549radiogroup1 = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "radiogroup1", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get rdDXT5() : RadioButton
        {
            return this._936778969rdDXT5;
        }// end function

        public function set rdDXT5(param1:RadioButton) : void
        {
            var _loc_2:* = this._936778969rdDXT5;
            if (_loc_2 !== param1)
            {
                this._936778969rdDXT5 = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rdDXT5", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get rdRGBA() : RadioButton
        {
            return this._936378778rdRGBA;
        }// end function

        public function set rdRGBA(param1:RadioButton) : void
        {
            var _loc_2:* = this._936378778rdRGBA;
            if (_loc_2 !== param1)
            {
                this._936378778rdRGBA = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rdRGBA", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get tOUT() : TextArea
        {
            return this._3534394tOUT;
        }// end function

        public function set tOUT(param1:TextArea) : void
        {
            var _loc_2:* = this._3534394tOUT;
            if (_loc_2 !== param1)
            {
                this._3534394tOUT = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tOUT", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get tP_Q() : TextInput
        {
            return this._3535662tP_Q;
        }// end function

        public function set tP_Q(param1:TextInput) : void
        {
            var _loc_2:* = this._3535662tP_Q;
            if (_loc_2 !== param1)
            {
                this._3535662tP_Q = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tP_Q", _loc_2, param1));
                }
            }
            return;
        }// end function

        public static function getFixBitmapData(param1:BitmapData) : BitmapData
        {
            var _loc_4:BitmapData = null;
            var _loc_2:* = getNextPowerOf2(param1.width);
            var _loc_3:* = getNextPowerOf2(param1.height);
            if (_loc_2 == param1.width && _loc_3 == param1.height)
            {
                _loc_4 = param1.clone();
            }
            else
            {
                _loc_4 = new BitmapData(_loc_2, _loc_3, true, 0);
                _loc_4.draw(param1);
            }
            return _loc_4;
        }// end function

        public static function getNextPowerOf2(param1:int) : int
        {
            var _loc_2:int = 0;
            if (param1 == 0)
            {
                return 2;
            }
            if (((param1 - 1) & param1) == 0)
            {
                return param1;
            }
            while (param1 > 0)
            {
                
                param1 = param1 >> 1;
                _loc_2++;
            }
            return 1 << _loc_2;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
